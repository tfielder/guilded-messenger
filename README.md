# README

# Summary
Author: Tim Fielder
Date: 02/18/2021
Version: 1.0

This is a simple prototype of a back-end API for the purpose of enabling a small
web application to send and receive short text messages. This project creates two simple
models: a User model and a Message model utilizing an API that leverages some basic CRUD functionality.
In addition to the basic operations provided by the API, this project additionally yields requests for:
1 - recent messages to a recipient by a specific sender.
2 - recent messages to a recipient by all senders.
3 - recent messages from all/any senders.

# Tech Used
Rails Version: 6.1.0
Ruby Version: 3.0.0
postgresql Version: 13.2

Gems:
rspec-rails
faker
shoulda-matchers

# Getting Started
Live:
1. Navigate to https://guilded-messenger.herokuapp.com/.
2. Follow the API usage listed below for specific endpoints.

Locally:
1. Clone this repo locally.
2. Run 'bundle' from the CLI.
3. To initialize the database run 'rails db:create' then 'rails db:migrate' from the CLI. Note the database is populated with seed data for initialization purposes.
4. To launch the project locally run 'rails s' from the command line. Choose your favorite browser and navigate to the URL listed in the output on the command line (typically localhost:3000).
5. Choose any endpoint to view retrieved data (see API usage section for more).

# API usage
The API can be leveraged to send and retrieve data - after building the project with the initial instructions in the "Getting Started" section, an exhaustive list can be found by running `rails routes` in the CLI. The following api endpoints and URIs can be used on top of the root path (localhost:3000 generally if building locally or https://guilded-messenger.herokuapp.com/ if using the live version) and are documented here as well as in the testing (see the testing section).

- GET '/'
produces the homepage of the app.
The live version can be accessed here: https://guilded-messenger.herokuapp.com/. Simply add the following endpoints to the root url.

API endpoints based on the spec:
(see additional endpoints section to view/retrieve user ids).
- GET '/api/user/:id_1/messages-from-sender/:id_2'
This endpoint is used to get messages sent to a specific recipient from a specific sender, where :id_1 represents the id of the recipient and :id_2 represents the sender. Results are limited to the last 30 days and first 100 results.

- GET '/api/user/:id/messages-to-user'
This endpoint retrieves any messages sent by any user to a particular user whose id is :id.  Example usage: localhost:3000/api/user/1/messages-to-user yields any messages to the user whose id is 1. This api endpoint is also limited to the last 30 days and up to 100 results.

- GET '/api/recent-messages'
This endpoint retrieves any and all messages sent by any user to any user, limited to the last 30 days and up to 100 results.

Additional endpoints:
- GET '/api/users'
shows the list of all users. Note the ids for use in retrieving messages by and from particular users.

- GET '/api/users/:id'
retrieves the data for a single user based on the user's id (:id).  E.g. 'localhost:3000/api/users/5'

- POST '/api/users'
allows you to create a new user record. When using a tool such as Postman - include the header with a key of Content-Type and value of application/json. The body of the post request should include a raw format such as { "user": { "first_name": "x", "last_name": "y" }} where x is the first name of the user and y is the last name of the user.

- DELETE '/api/users/:id'
endpoint to delete a message using the user id of :id. E.g. 'localhost:3000/api/users/5'.

- GET '/api/messages'
retrieves the data for all messages. Note this endpoint is not limited by date or number of returned objects.

- GET '/api/messages/:id'
retrieves a specific message by the message id. This endpoint is used to retrieve a single message by id.

- POST '/api/messages'
allows you to create a new message record. When using a tool such as Postman - include the header with a key of Content-Type and value of application/json. The body of the post request should include a raw format such as { "message": { "subject": "x", "body": "y", "sender_id": "z", "receiver_id": "w" }} where x is the subject of the message, y is the content of the message, z is the id of the sender (be sure one exists), and w is the id of the intended recipient (be sure one exists). Troubleshooting: Verify the recipient id exists via the 'api/users' endpoint.

- DELETE 'api/messages/:id'
endpoint to delete a particular message where :id is the message id.

# Testing
Testing may be run from the CLI. After initializing the project through the instructions in the "Getting Started" section, run `rspec` from the command line to run tests. Testing is located in the spec directory and contains testing for both models and api requests under their respective sub directories.

# Next Steps
Given additional time, additional testing, refactoring of code, and building out additional CRUD functionality (update function) would be included.

# Assumptions
The API endpoints as designed are limited both by number of entries and by date (last 30 days).
The API could be parameterized to retrieve the data based on one condition or the other. I prioritized functionality, including a live version, and documentation in this release.