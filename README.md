# README

Rails 7
Ruby 3.0.0

See make file for commands to run, to start the app run `make run`

To run the app in the background, run `make start`

For rails console, run `make console`

To setup db, run `make db.setup`

To view sidekiq logs, run `make logs.workers`

Sidekiq UI can be viewed at `http://localhost:3000/api/sidekiq`

There is a test api endpoint created, this endpoint also kicks off a sidekiq job
- `make run`
- `curl localhost:3000/api/authors`


As this is a setup for a development environment, the docker container uses `.:/usr/src/app` as the source, not a built image. Any code changes saved will be reflected live in the container.
