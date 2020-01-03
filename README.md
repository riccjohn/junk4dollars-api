# Junk4Dollars

[![Build Status](https://travis-ci.com/riccjohn/junk4dollars-api.svg?branch=master)](https://travis-ci.com/riccjohn/junk4dollars-api)

# Installation

Clone this repo

```zsh
git clone git@github.com:riccjohn/junk4dollars-api.git
```

Install dependencies

System Dependencies

- [Postgres](https://www.postgresql.org/)
- [Ruby 2.6.4](https://www.ruby-lang.org/en/documentation/installation/)

Bundler

```zsh
gem install bundler
```

Make sure you have Postgres running

```zsh
cd junk4dollars-api && bundle install
```

## Common Problems

- Nokogiri fails due to missing dependencies

  - Make sure you have `libxslt-dev libxml2-dev zlib1g-dev` installed

- `pg` fails to install (usually on Linux)
  - Make sure you have `postgresql` and `libpq` installed.
    ```zsh
    sudo apt-get install postgresql # osx => brew install posgresql
    sudo apt-get install libpq-dev
    ```

## Set up the databasees

```zsh
bundle exec rake db:create
```

This should create 3 databases

- `junk4dollars_development`
- `junk4dollars_test`
- `junk4dollars_production`

Run migration

```zsh
rails db:migrate
```

## Starting the server locally

From within the `junk4dollars-api` directory

```zsh
rails server
```

Visit `localhost:3000` in your browser

## Starting the server in production

You'll need to find your Rails master key to allow you to access the encrypted information in your credientials file. Your master key should be in `config/master.key`

To get the production database built:
`RAILS_ENV=production RAILS_MASTER_KEY="MASTER_KEY_HERE" bundle exec rake db:setup`

Start the production server
`RAILS_MASTER_KEY="MASTER_KEY_HERE" rails s -e production`

## Tests

Run tests locally: `bundle exec rake test`

Note: Tests are set to run in parallel, so you'll see multiple test databases are created the first time you run the tests.

## CI

[Travis CI](https://travis-ci.com/riccjohn/junk4dollars-api) will:

- Run all tests
- Run Rubocop to make sure there are no formatting offenses

## Linting

Rubocop

Run Rubocop locally to find formatting errors: `bundle exec rake rubocop`

Run Rubocop to auto-fix all formatting errors: `bundle exec rake rubocop:auto_correct`

---

# API

| Route              | Method | Usage                                         |
| ------------------ | ------ | --------------------------------------------- |
| `/users/`          | GET    | Return list of all users (non-sensitive data) |
| `/users/:id`       | GET    | Return single user by ID (non-sensitive data) |
| `/auctions/`       | GET    | Return list of all auctions                   |
| `/auctions/:id`    | GET    | Return single auction by ID                   |
| `/me`              | GET    | Return data on auth0 authenticated user       |
| `/bid/:auction_id` | POST   | Create a new auction if logged in             |
