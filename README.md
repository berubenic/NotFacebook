# NotFacebook

Ruby on Rails social network project

[Link to project instructions](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-on-rails/lessons/final-project)

[View app in browser (30 seconds for Heroku Dyno to wake up)](https://berube-notfacebook.herokuapp.com/)

## Project Requirements
#
This project replicates the core functionalities of a social media application like Facebook. 

The application is fully tested to ensure everything behaves as needed.

## Demo
#

## Features
#
- User authentication using [Devise](https://github.com/heartcombo/devise).
- Implented a PostreSQL database
- Images are hosted with [Cloudinary](https://cloudinary.com/)
- User uploads a profile picture.
- User creates a post with text or image.
- User likes posts and comments.
- User comments on posts.
- User adds and removes friends.
- User sees friends' posts.

## Installation
#
1. Clone the repository. ([Instructions](Instructions))
2. Navigate into the project's directory. ```cd NotFacebook```
3. Install the required gems. ```bundle install```
4. Setup the database. ```rails db:create db:migrate db:seed```
5. Start the local server. ```rails server```
6. Open a browser and visit ```http://localhost:3000```

## Running Specs
#
- Navigate into the project's directory and run ```rspec``` to run the entire spec suite.
- See the [Rspec documentation](https://github.com/rspec/rspec-rails#running-specs) for more ways to run specs.
