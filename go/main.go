package main

import (
	"database/sql"
	"encoding/json"
	"html/template"
	"io/ioutil"
	"log"
	"net/http"
	"sync"
	"time"

	_ "github.com/lib/pq" // sql database driver; understandable that it is not in core libs; because it is db vendor specific
)

var (
	db                   *sql.DB            // database connection
	tplProverbs, tplCats *template.Template // the templates we are going to use
)

// Proverb represents structure of the data that will be fetched from the proverbs database table
type Proverb struct {
	ID      string
	Proverb string
	URL     string
}

// Cat represents structure of data that will be fetched from the random cat endpoint, used in catsHandler
type Cat struct {
	File string `json:"file"`
}

func init() {
	var err error

	// initialize database connection
	// connection pool is managed by the sql package
	db, err = sql.Open("postgres", "postgres://fx:fx@localhost:8041/fx?sslmode=disable")
	if err == nil {
		log.Println("Connected to database successfully.")
	} else {
		log.Fatal("Database connection failed: ", err)
	}

	err = db.Ping()
	if err == nil {
		log.Println("Pinged database successfully.")
	} else {
		log.Fatal("Database ping failed: ", err)
	}

	// next we load the templates
	// simple wrapper function to create a template object from template file
	tplLoader := func(name string) *template.Template {
		// templates are loaded from disk
		// meaning they have to be distributed with the executable - not ideal
		// there are external packages that can automatically embed them within the executable
		// one of my favourites is https://github.com/GeertJohan/go.rice
		// but for this example, no external packages will be used
		raw, err := ioutil.ReadFile("templates/" + name + ".html.tmpl")
		if err != nil {
			log.Fatalln("Failed to load template " + name)
		}

		tpl, err := template.New(name).Parse(string(raw))
		if err != nil {
			log.Fatalln("Failed to load template " + name)
		}

		return tpl
	}

	tplProverbs = tplLoader("proverbs")
	tplCats = tplLoader("cats")
}

func main() {
	// http multiplexer, will handle routing for us
	mux := http.NewServeMux()
	mux.HandleFunc("/", homepageHandler)
	mux.HandleFunc("/cats", catsHandler)

	// create a server, we can fine-tune
	srv := &http.Server{
		Handler:      mux,
		Addr:         ":8000",
		ReadTimeout:  5 * time.Second,
		WriteTimeout: 10 * time.Second,
		IdleTimeout:  15 * time.Second,
	}

	log.Println("Listening on http://127.0.0.1:8000")
	if err := srv.ListenAndServe(); err != nil {
		log.Fatalf("error starting http server: %v", err)
	}
}

func homepageHandler(w http.ResponseWriter, r *http.Request) {
	var proverbs []Proverb

	// we can delegate updating stats table in a separate go routine
	// it needs not delay the actual response; neat!
	go func() {
		db.Query("UPDATE stats SET visits = visits+1 WHERE url = '/'")
	}()

	rows, err := db.Query(`SELECT id, proverb, url FROM proverbs`)
	if err != nil {
		log.Fatal(err)
	}

	defer rows.Close()
	for rows.Next() {
		var proverb Proverb
		rows.Scan(&proverb.ID, &proverb.Proverb, &proverb.URL)
		proverbs = append(proverbs, proverb)
	}

	tplProverbs.Execute(w, proverbs)
}

func catsHandler(w http.ResponseWriter, r *http.Request) {
	var (
		cats []Cat
		tube = make(chan Cat)
		wg   sync.WaitGroup
	)

	// statements using defer keyword are guaranteed to execute when the function body is done
	// they execute on a LIFO basis
	defer close(tube)

	// this function gets a cat and puts it in a tube
	getCat := func() {
		var cat Cat

		client := &http.Client{Timeout: time.Second * 30}
		rs, _ := client.Get("https://aws.random.cat/meow")
		res, _ := ioutil.ReadAll(rs.Body)
		json.Unmarshal(res, &cat)
		tube <- cat
	}

	wg.Add(4) // we are going to get 4 cats, asynchronously, so we have to ensure we wait for those
	go getCat()
	go getCat()
	go getCat()
	go getCat()

	// this is yet another routine that will take cats from the tube and append to our list
	// only 1 routine is writing to the list, so no mutex needed
	// synchronization is handled automatically
	go func() {
		for cat := range tube {
			cats = append(cats, cat)
			wg.Done()
		}
	}()

	wg.Wait()
	tplCats.Execute(w, cats)
}
