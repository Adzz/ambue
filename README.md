# Ambue

To get started I added a Makefile, so you can run the following:

### Booting the App

The very first time:

```sh
make start_db_hidden
mix ecto.create
MIX_ENV=test mix ecto.create
make migrate
make start
```

Thereafter:

Start the db:

```sh
make start_db_hidden
```

The app:
```sh
make start
```


### Tests

The very first time:

```sh
make start_db_hidden
mix ecto.create
MIX_ENV=test  mix ecto.create
mix test
```

Thereafter:

```sh
mix test
```
