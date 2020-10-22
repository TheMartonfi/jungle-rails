# Jungle

A mini e-commerce application built with Rails 4.2.

## Dependencies

- Rails 4.2 [Rails Guide](http://guides.rubyonrails.org/v4.2/)
- PostgreSQL 9.x
- Stripe

## Setup

1. Run `bundle install` to install dependencies
2. Create `config/database.yml` by copying `config/database.example.yml`
3. Create `config/secrets.yml` by copying `config/secrets.example.yml`
4. Run `bin/rake db:reset` to create, load and seed db
5. Create .env file based on .env.example
6. Sign up for a Stripe account
7. Put Stripe (test) keys into appropriate .env vars
8. Run `bin/rails s` to start the server
9. Go to <http://localhost:3000/> in your browser.

## Screenshots

!['Home'](https://github.com/TheMartonfi/scheduler/blob/master/docs/home.png?raw=true)
!['Book interview'](https://github.com/TheMartonfi/scheduler/blob/master/docs/book-interview.png?raw=true)
!['Booked interview'](https://github.com/TheMartonfi/scheduler/blob/master/docs/booked-interview.png?raw=true)
!['Delete'](https://github.com/TheMartonfi/scheduler/blob/master/docs/delete.png)
