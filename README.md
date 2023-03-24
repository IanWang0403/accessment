# HOMETIME ACCESSMENT

This is a Ruby on Rails project built with Rails 7.0.4 and Ruby 3.0.4. It uses PostgreSQL as the database, Sidekiq for background processing, RSpec for testing, and Airbrake for error handling.

## Prerequisites

- Ruby 3.0.4
- Rails 7.0.4
- PostgreSQL 13+
- Redis 6+

## Getting Started

To set up the project, follow these steps:

1. Clone the repository:

```
git clone https://github.com/IanWang0403/accessment.git
cd hometime_accessment
```

2. Install the required gems:

```
bundle install
```

3. Set up your Rails credentials:

Run the following command to edit your encrypted credentials if you want to run this project on production. You should delete the specific environment's yml.enc and use the following code to generate a new one. (The following code using vscode)

```
EDITOR='code --wait' rails credentials:edit -e [environment]
```

Add your database username, password, and Airbrake project_id and project_key to the credentials file:

```yaml
database:
  username: your_database_username
  password: your_database_password

airbrake:
  project_id: your_airbrake_project_id
  project_key: your_airbrake_project_key
```

4. Create and set up the database:

```
rails db:create
rails db:migrate
```

5. Start the Rails server:

```
rails server
```

6. Start Sidekiq (in a separate terminal):

```
bundle exec sidekiq
```

You should now be able to sent post request to the end point at `http://localhost:3000/webhooks/reservations`.

your webhook should include event_type and payload example:

```json
{
  "event_type": "test",
  "payload": {
    "reservation": {
      "code": "YYY12345678",
      "start_date": "2021-03-12",
      "end_date": "2021-03-16",
      "expected_payout_amount": "3800.00",
      "guest_details": {
        "localized_description": "4 guests",
        "number_of_adults": 2,
        "number_of_children": 2,
        "number_of_infants": 0
      },
      "guest_email": "wayne_woodbridge@bnb.com",
      "guest_first_name": "Wayne",
      "guest_last_name": "Woodbridge",
      "guest_phone_numbers": ["639123456789", "639123456789"],
      "listing_security_price_accurate": "520.00",
      "host_currency": "AUD",
      "nights": 4,
      "number_of_guests": 4,
      "status_type": "accepted",
      "total_paid_amount_accurate": "4300.00"
    }
  }
}
```

## Running Tests

To run the test suite, execute:

```
rspec
```

## Error Handling

If you do not want to use airbrake. You can also use [Exception Notification](https://github.com/smartinez87/exception_notification)
