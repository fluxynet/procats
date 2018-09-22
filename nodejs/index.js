// Code has been formatted using prettify extension on vscode; ensure all your team members are using the same thing!
const https = require("https");
const http = require("http");
const fs = require("fs");
const { Pool, Client } = require("pg"); // pg package used for database; it is understandable for it not to be in core libs; because it is db vendor specific

// had to break the rule of not using external packages; we have loops in our templates, would be too complicated to implement locally :(
const handlebars = require("handlebars");

// templates loading
const tplProverbs = handlebars.compile(
	fs.readFileSync("templates/proverbs.tpl.html", "utf-8")
);
const tplCats = handlebars.compile(
	fs.readFileSync("templates/cats.tpl.html", "utf-8")
);

function homepageHandler(req, res) {
	const pool = new Pool({
		user: "fx",
		host: "postgres",
		database: "fx",
		password: "fx",
		port: 5432
	});

	// we can delegate updating stats table in a separate thread
	// it needs not delay the actual response; neat!
	pool.query("UPDATE stats SET visits = visits+1 WHERE url = '/'");

	pool.query("SELECT id, proverb, url FROM proverbs", (err, results) => {
		res.write(tplProverbs({ proverbs: results.rows }));
		pool.end();
		res.end();
	});
}

// we used different syntax for homepageHandler and catsHandler
// the end result is the same...
const catsHandler = function(req, res) {
	cats = [];

	// in real-life scenario, a proper library (axios?) would be used for requests
	// but we are not using those
	// it helps us understand the guiding philosophy of the language - async everything; what about the syntax - is it human friendly?
	const getCat = function(callback) {
		https
			.get("https://aws.random.cat/meow", resp => {
				// yet another way to define a function, with a subtle difference, do you know what it is?
				let data = "";
				resp.on("data", chunk => {
					data += chunk;
				});
				resp.on("end", () => {
					callback(JSON.parse(data));
				});
			})
			.on("error", err => {
				res.write(err.message);
				res.end();
			});
	};

	// callback to our cats function
	// we are assuming the cats.push function is thread-safe; is it?
	const gotCat = function(cat) {
		cats.push(cat);
		if (cats.length == 4) {
			res.write(tplCats({ cats }));
			res.end();
		}
	};

	getCat(gotCat);
	getCat(gotCat);
	getCat(gotCat);
	getCat(gotCat);
};

const server = http.createServer((req, res) => {
	if (req.url === "/") {
		homepageHandler(req, res);
	} else if (req.url === "/cats") {
		catsHandler(req, res);
	} else {
		res.writeHead(404);
		res.write("404");
	}
});

server.listen(8001, err => {
	if (err) {
		return console.log("something bad happened", err);
	}

	console.log(`server is listening on 8001`);
});
