.PHONY: start full_start start_db_hidden deps start_db migrate reset_db

full_start: deps start_db_hidden start

reset_db:
	mix do ecto.drop, ecto.create
	MIX_ENV=test mix do ecto.drop, ecto.create

deps:
	mix deps.get

start_db_hidden:
	docker-compose up -d postgres

start_db:
	docker-compose up postgres

start:
	iex -S mix phx.server

stop_db:
	docker-compose down

migrate:
	mix do ecto.migrate, ecto.dump
	MIX_ENV=test mix ecto.test.prepare
