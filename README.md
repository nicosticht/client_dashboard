# Project Title

This is part of a code challenge. It's a basic rails application with the following Models: Company, Employee,
PartnerCompany, Contractor and Client

- Authentication;
- Simple UI with bootstrap
- CRUD for all models

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

## Changes needed to upgrade Ruby to version 3.0+ and Rails to version 6.0+

Sqlite3 version 1.3.13 is not comptiable with ruby 3.0+, so please upgrade to version 1.4+ is a must otherwise bundle install command will give an error about sqlite3 gem installation.

To upgrade rails to 6.0+, I have just changed the version in Gemfile to 6.1.4 and run command

```
$ bundle update
```

# More Info about upgrading Ruby on Rails is available on the following website:

https://edgeguides.rubyonrails.org/upgrading_ruby_on_rails.html


### Installing

Clone git repository and run bundle install:

```
$ git clone git@github.com:nicosticht/client_dashboard.git
$ bundle install
```

Set up the database:

```
$ rails db:setup
```

Run the rails server:

```
$ rails s
```

## Running the tests

To run the tests execute following statement:

```
$ bundle exec rake
```


## License

This project is licensed under the MIT License - see the [LICENSE.txt](LICENSE.txt) file for details

