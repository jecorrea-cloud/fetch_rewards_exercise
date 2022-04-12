# Fetch Points App

## Table of Contents

- [Description](#description)
- [Installations](#installations)
- [Models](#models)
- [Routes](#routes)
- [Technologies Used](#technologies-used)
- [Future Ideas](#future-ideas)

## Description

This is a REST API service used to track payers' points in a database. This is accomplished through 3 endpoints which allow the user to check all existing payers' balances, add transactions for a specific payer and date, and spend(substract) the current points from all payers.

## Installations

- Clone _this_ repo in _command line_: `git clone ` and one of the links below
  - **HTTPS:** `https://github.com/jecorrea-cloud/fetch_exercise.git`
  - **SSH:** `git@github.com:jecorrea-cloud/fetch_exercise.git`
- `cd` into the project and install in _command line_:

  - _ruby_:
    - **Ubuntu:**
      1. install RVM and Ruby by running the following commands:
      - `gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3`
      - `\curl -sSL https://get.rvm.io | bash`
      - `echo "[[ -s "$HOME/.rvm/scripts/rvm" ]]" && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*`
      - `rvm install 3.1.1`
      - `rvm use 3.1.1 --default`
      - `gem install bundler`
    - **MacOS:**
      1. install Homebrew by running: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
      2. run `brew install gmp` and `brew install gnupg` to install GMP and GnuPG locally.
      3. run `gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB` as a first step needed for the encryption keys to download RVM.
      4. run `curl -sSL https://get.rvm.io | bash` to download RVM.
      5. run `rvm install 3.1.1` and `rvm use 3.1.1 --default` to install Ruby and set this version as default. Run `ruby -v` to check the version.
      6. run `gem install bundler` to install the bundler gem.
    - **Windows WSL:**
      1. to install dependencies, run `sudo apt-get update` and then run `sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev libpq-dev libgdbm-dev libncurses5-dev automake libtool bison gnupg postgresql postgresql-contrib`
      2. install RVM by running `gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB`
      3. check if curl is installed by running `curl -V`. If not, run `sudo apt-get install curl`. Then run `\curl -sSL https://get.rvm.io | bash -s stable --ruby`
      4. run `rvm install 3.1.1` and `rvm use 3.1.1 --default` to install Ruby and set this version as default. Run `ruby -v` to check the version.
      5. run `gem install bundler` to install the bundler gem.
  - _rails_: in _command line_ run: `gem install rails`
  - run `bundle install` to download all the provided gems.
  - run `rails db:migrate db:seed` to run the migrations and seed file locally.
  - run `rails db:reset` to restart the database at any time with the current values on the seed file.
    > **Note**:If you are not able to get the provided `seeds.rb` file working, you are welcome to
    > generate your own seed data to test the application.
  - unit tests have been provided in the spec folder. In _command line_ run: `rspec` to run all of them.
  - run `rails s` to run the Rails API on [`localhost:3000`](http://localhost:3000). Press `Ctrl+C` to
    shut it down.

- Once the server is up and running, run [Postman](https://www.postman.com/downloads/) to test each endpoint.

## Models

This app contains the following model:

- A `Transaction`

The model and migrations are based on the following database table:

![domain diagram](domain.png)

There are four validations to the `Transaction` model:

- must have a `payer` name that is not blank (has to exist).
- must have existing **integer type** (numerical) `points` that are not blank.
- `points` are always positive. They cannot be less than zero.
- must have an existing `timestamp` that is not blank.

## Routes

The application contains the following specified routes along with the appropriate HTTP verb.

### GET /balances

For all existing recent `Transaction`s created, return JSON data in the format below without repeating payers:

```json
[
  {
    "DANNON": 1300,
    "UNILEVER": 200,
    "MILLER COORS": 10000
  }
]
```

### POST /add_transaction

This route creates a new `Transaction`. It accepts a hash with the following properties in the body of the request:

```json
{
  "payer": "DANNON",
  "points": 300,
  "timestamp": "2020-10-31T10:00:00Z"
}
```

If the `Transaction` is created successfully, it sends back a response with the data, along with the appropriate HTTP status code:

```json
{
  "payer": "DANNON",
  "points": 300,
  "timestamp": "2020-10-31T10:00:00Z"
}
```

If the `Transaction` is **not** created successfully, it returns the following JSON data, along with the appropriate
HTTP status code:

```json
{
  "errors": ["validation errors"]
}
```

### POST /spend_points

This route substracts a fixed amount of points for every existing payer. It accepts an object with the following property in the body of the request below:

```json
{
  "points": 5000
}
```

If a `Transaction` has a payer that is repeated, it substracts the appropriate points based on the oldest timestamp that exists while ensuring its points do not go below zero.

The expected response from the spend call would be:

```json
[
  { "payer": "DANNON", "points": -300 },
  { "payer": "UNILEVER", "points": -200 },
  { "payer": "MILLER COORS", "points": -4,500 }
]
```

If the input `points` in the body of the request are less than or equal to zero, or exceed the total existing `points`
amount in the database, the expected response from the call is:

```json
{
  "errors": "Invalid input. Input Points cannot be negative, zero or greater than the current balances."
}
```

## Technologies Used

- **Ruby 3.1.1** and **Ruby on Rails 7.0.2.3**
- **Postman 9.15.10** to test API routes

## Future Ideas

- Connect the API to a front end interface.
- Figure out a way to see all transactions for each existing payer based on `payer`.
- Figure out a way to search for transactions based on the `timestamp`.
