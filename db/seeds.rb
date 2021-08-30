# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([{ first_name: 'Joe', last_name: 'Picket', email: 'joe_picket@email.com', password: 'joe_picket' },
                     { first_name: 'Patrick', last_name: 'StarFish', email: 'patrick_starfish@email.com',
                       password: 'patrick_starfish' },
                     { first_name: 'Spongebob', last_name: 'SquarePants', email: 'spongebob_squarepants@email.com',
                       password: 'spongebob_squarepants' }])

posts = Post.create([{ body: "Hello! I'm first!!!", user: users[0] }, { body: 'Nobody cares bro!', user: users[1] },
                     { body: "Can't sleep... Who's up???", user: users[2] }])
