# Procats
Proverbs and Cats to compare GoLang to nodejs and php

This is a simple website implemented in several programming languages:
- Go (1.11)
- NodeJS (9.4)
- PHP (7.1)

The idea is to use only core packages; except for database drivers - because this are vendor specific.
All implementations use docker-compose.

# Objective
Create a simple website with 2 endponts:
- Homepage `/` updates a statistics counter, and provides a listing of proverbs in a (postgres) database
- Cats `/cats` contacts an external service to obtain 4 cat images.

# Implementations

NodeJS and PHP include docker-compose configuration such that all dependencies are preloaded; run `docker-compose up -d` in the respective directories in order ot start them.

For Go, [install Go 1.11](https://golang.org/dl/), and run the following to start: `docker-compose up -d && go build && ./go`

The websites run on the following ports:
- Go `http://127.0.0.1:8000` (database accessible via `port 8010`)
- NodeJS `http://127.0.0.1:8001` (database accessible via `port 8011`)
- PHP `http://127.0.0.1:8002` (database accessible via `port 8012`)

## Go
- Once the code is compiled it can run without any external dependencies; except for the template files already included.

## NodeJS
- Nodejs has been made to run within docker image containing `node` installation with pre-executed `npm install`.
- This approach is to make it easier for you to run the code, but bear in mind that setting up such an environment with appropriate node version would be system admin responsibility.

## PHP
- The PHP stack was the hardest to set up. Rather than giving steps to run for the setup, the `docker-compose.yml` and appropriate `Dockerfiles` have been included.
- The stack requires both `nginx` and `php-fpm`; although apache with php could have been used. I believe it is necessary for the http server and fpm server to be used separately for clarity has to how requests are processed.
- The docker images use alpine rather than ubuntu and `apt-get`; again for clarity onto the complexity that system admins may endure when providing tailored php environments.

# Reach Out!
The code is well-documented via inline comments; if you have any further questions, comments or corrections, [let me know](http://fluxy.net/code/procats/) or join us on [Gophers.mu](https://www.gophers.mu/) 👍
