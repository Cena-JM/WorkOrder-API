# Work Orders API

An app that has work orders and workers. A work order is a job to be completed 
by one or more workers. One or more workers are ‘assigned’ to an order. A max of 5 workers can work on one order.

## Contributors

[Musa Jabbaaru Ntege](https://github.com/Cena-JM)

## Heroku version

https://dashboard.heroku.com/apps/salty-lake-93985

## Requirements

Ruby 2.6.2
Postgresql 1.1.4
Ruby on Rails 5.2.3

## Dependencies

rspec-rails - Testing framework.
factory_bot_rails - A fixtures replacement with a more straightforward syntax. You'll see.
shoulda_matchers - Provides RSpec with additional matchers.
database_cleaner - Cleans our test database to ensure a clean state in each test suite.
faker - A library for generating fake data. We'll use this to generate test data.

## How it works

The app has three models (worker, work_order, assignment). Workers are connected to work orders through assignments. Each work order can be assigned not more than five workers and workers can be assigned to multiple work orders.

## Getting started

To get started with the app, clone the repo

```

and then install the needed gems:
```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the server and have fun:

```
$ rails server
```