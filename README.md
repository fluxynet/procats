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

## GoLang
- Once the code is compiled it can run without any external dependencies; except for the template files already included.

## NodeJS
- The nodejs runtime must be present to execute the program. It must support the language features used in the script.
- Be sure to run `npm install` within the `nodejs` directory for external dependencies (database drivers, and sadly, handlebars).

## PHP
- The PHP stack was the hardest to set up. Rather than giving steps to run for the setup, the `docker-compose.yml` and appropriate `Dockerfiles` have been included.
- The stack requires both `nginx` and `php-fpm`; although apache with php could have been used. I believe it is necessary for the http server and fpm server to be used separately for clarity has to how requests are processed.
- The docker images use alpine rather than ubuntu and `apt-get`; again for clarity onto the complexity that system admins may endure when providing tailored php environments.

# Reach Out!
The code is well-documented via inline comments; if you have any further questions, comments or corrections, be sure to ask via email `fx@fluxy.net` or, better, join us on [https://www.gophers.mu/](Gophers.mu)
