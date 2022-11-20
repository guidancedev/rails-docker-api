# Setup
build:
	docker-compose build web 

run: # start the app
	docker-compose up --build web

start: # run app in background
	docker-compose up --build -d web

stop: # tear down running app containers
	docker-compose down

console: # rails console
	docker-compose run --rm web bash -c "bundle exec rails c"

logs: # app logs
	docker-compose logs --follow --tail=1000 web

shell: # for running commands on the server (eg. rails routes)
	docker-compose run --rm web bash

# DB
db.setup: # drop and create the database
	docker-compose run --rm web bundle exec rails db:drop db:create

db.migrate: # migrate the database
	docker-compose run --rm web bundle exec rails db:migrate

db.seed: # seed the database
	docker-compose run --rm web bundle exec rails db:seed

db.reset: # drop, create, migrate and seed the db
	docker-compose run --rm web bundle exec rails db:drop db:create db:migrate db:seed

db.rollback: # rollback the most recent migration
	docker-compose run --rm web bash -c "bundle exec rails db:rollback"

db.schema.load: ## loads the schema into the database
	docker-compose run --rm admin bundle exec rails db:schema:load

# Sidekiq
logs.workers: # sidekiq logs
	docker-compose logs --follow --tail=1000 sidekiq


# rake tasks?
# tests?