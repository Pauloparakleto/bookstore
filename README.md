# README


Project overview
Rails 6.1 app, uses webpacker for building assets, materialize CSS framework
(https://materializecss.com/) . The repo is available at https://gerrit.buburuza.org/stan/bookstore
Setup instructions
1. Clone repo
2. Install docker
3. Install docker-compose
4. Run docker-compose up
5. Go to http://localhost:18210/books

## Task 1

Implement user authentication system - sign up, sign in, sign out, password recovery.

Hints:

● use email as an identifier

## Task 2

Implement an admin module for managing books and authors.
Hints:

● Should be implemented from scratch

● Views should be as simple as possible (in terms of the UI)
Requirements:

● Add roles for users - admin/customer

● Validation should be added to all the models

● Every update to any model should be recorded in a separate audit table (needs to be
added)

● It should be possible to update book title, price, published state

● It should be possible to update author first name, last name

● It should be possible to delete/block users. If an user is blocked, when they’re trying to
log in, a “You are blocked, please contact support” message should be displayed

## Task 3

Add the possibility for a logged user to add books to their shopping cart

Requirements:

● Add a quantity attribute to books

● It should not be possible to add a book if its quantity is zero

● Shopping cart contents should be saved in the DB (in order to be persistent between
browsers)

● Shopping cart details should be implemented as a separate page that will show a
summary of what has been added and will include a total price
General notes

● Ruby style guide should be used: https://github.com/rubocop/ruby-style-guide

● Rails documentation is available at https://guides.rubyonrails.org/ and
https://api.rubyonrails.org/

● Unit tests (using rspec) need to be added for models

● One unit test per controller action needs to be added in order to confirm that the
functionality is working as expected
