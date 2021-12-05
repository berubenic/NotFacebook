# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users =
    [
      {
        first_name: 'Joe',
        last_name: 'Picket',
        email: 'joe_picket@email.com',
        password: 'joe_picket'
      },
      {
        first_name: 'Patrick',
        last_name: 'StarFish',
        email: 'patrick_starfish@email.com',
        password: 'patrick_starfish'
      },
      {
        first_name: 'Spongebob',
        last_name: 'SquarePants',
        email: 'spongebob_squarepants@email.com',
        password: 'spongebob_squarepants'
      },
      {
        first_name: 'John',
        last_name: 'Cena',
        email: 'jogn_cena@email.com',
        password: 'john_cena'
      },
      {
        first_name: 'Tony',
        last_name: 'Hawk',
        email: 'tony_hawk@email.com',
        password: 'tony_hawk'
      },
      {
        first_name: 'Bart',
        last_name: 'Simpson',
        email: 'bart_simpson@email.com',
        password: 'bart_simpson'
      },
      {
        first_name: 'Homer',
        last_name: 'Simpson',
        email: 'homer_simpson@email.com',
        password: 'homer_simpson'
      },
      {
        first_name: 'Harry',
        last_name: 'Potter',
        email: 'harry_potter@email.com',
        password: 'harry_potter'
      },
      {
        first_name: 'Ron',
        last_name: 'Weasley',
        email: 'ron_weasley@email.com',
        password: 'ron_weasley'
      },
      {
        first_name: 'Donald',
        last_name: 'Duck',
        email: 'donald_duck@email.com',
        password: 'donald_duck'
      },
      {
        first_name: 'example',
        last_name: 'test',
        email: 'example_test@email.com',
        password: 'example_test'
      }
    ]
User.create(users)

joe = User.find_by(first_name: 'Joe' )
patrick = User.find_by(first_name: 'Patrick')
spongebob = User.find_by(first_name: 'Spongebob')
john = User.find_by(first_name: 'John' )
tony = User.find_by(first_name: 'Tony')
bart = User.find_by(first_name: 'Bart')
homer = User.find_by(first_name: 'Homer')
harry = User.find_by(first_name: 'Harry')
ron = User.find_by(first_name: 'Ron')
donald = User.find_by(first_name: 'Donald')
example = User.find_by(first_name: 'example')

joe.profile_image.attach(io: File.open('app/assets/images/profile_images/joe_picket.jpeg'), filename: 'joe_picket.jpeg')
patrick.profile_image.attach(io: File.open('app/assets/images/profile_images/patrick_starfish.png'), filename: 'patrick_starfish.png')
spongebob.profile_image.attach(io: File.open('app/assets/images/profile_images/spongebob_squarepants.jpeg'), filename: 'spongebob_squarepants.jpeg')
john.profile_image.attach(io: File.open('app/assets/images/profile_images/john_cena.jpg'), filename: 'john_cena.jpg')
tony.profile_image.attach(io: File.open('app/assets/images/profile_images/tony_hawk.jpeg'), filename: 'tony_hawk.jpeg')
bart.profile_image.attach(io: File.open('app/assets/images/profile_images/bart_simpson.png'), filename: 'bart_simpson.png')
homer.profile_image.attach(io: File.open('app/assets/images/profile_images/homer_simpson.png'), filename: 'homer_simpson.png')
harry.profile_image.attach(io: File.open('app/assets/images/profile_images/harry_potter.jpg'), filename: 'harry_potter.jpg')
ron.profile_image.attach(io: File.open('app/assets/images/profile_images/ron_weasley.jpg'), filename: 'ron_weasley.jpg')
donald.profile_image.attach(io: File.open('app/assets/images/profile_images/donald_duck.png'), filename: 'donald_duck.png')


friendships = [
  {
    user_id: example.id,
    friend_id: patrick.id,
    confirmed: true
  },
  {
    user_id: example.id,
    friend_id: spongebob.id,
    confirmed: true
  },
  {
    user_id: example.id,
    friend_id: john.id,
    confirmed: true
  },
  {
    user_id: example.id,
    friend_id: tony.id,
    confirmed: true
  },
  {
    user_id: example.id,
    friend_id: bart.id,
    confirmed: true
  },
  {
    user_id: example.id,
    friend_id: homer.id,
    confirmed: false
  },
  {
    user_id: example.id,
    friend_id: harry.id,
    confirmed: false
  }
]

Friendship.create(friendships)

posts = [
  {
    body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    user_id: example.id
  },
  {
    body: 'Take a look at my house!',
    user_id: patrick.id
  },
  {
    body: 'Mine is way better!',
    user_id: spongebob.id
  },
  {
    body: 'JOOOOOOOOHHHHNNNN CENNNNNAAAAAAAAAAA',
    user_id: john.id
  },
  {
    body: 'Hi, I am a pro skater. :)',
    user_id: tony.id
  },
  {
    body: 'Eat my shorts!',
    user_id: bart.id
  },
  {
    body: 'Roads are just a suggestion Marge, just like pants.',
    user_id: homer.id
  },
  {
    body: "If you want to know what a man's like, take a good look at how he treats his inferiors, not his equals.",
    user_id: harry.id
  },
]

Post.create(posts)

patrick_post = Post.find_by(user_id: patrick.id)
spongebob_post = Post.find_by(user_id: spongebob.id)
john_post = Post.find_by(user_id: john.id)
example_post = Post.find_by(user_id: example.id)

patrick_post.post_image.attach(io: File.open('app/assets/images/post_images/patrick_starfish_post.jpg'), filename: 'patrick_starfish_post.jpg')
spongebob_post.post_image.attach(io: File.open('app/assets/images/post_images/spongebob_squarepants_post.jpg'), filename: 'spongebob_squarepants_post.jpg')
john_post.post_image.attach(io: File.open('app/assets/images/post_images/john_cena_post.jpg'), filename: 'john_cena_post.jpg')

comments = [
  {
    body: 'Nice post!',
    user_id: patrick.id,
    post_id: example_post.id
  },
  {
    body: 'Interesting...',
    user_id: spongebob.id,
    post_id: example_post.id
  },
  {
    body: 'Never though about it this way.',
    user_id: john.id,
    post_id: example_post.id
  }
]

Comment.create(comments)

patrick_comment = Comment.find_by(user_id: patrick.id)

likes = [
  {
    user_id: spongebob.id,
    post_id: example_post.id,
    category: 'post'
  },
  {
    user_id: patrick.id,
    post_id: example_post.id,
    category: 'post'
  },
  {
    user_id: john.id,
    post_id: example_post.id,
    category: 'post'
  },
  {
    user_id: john.id,
    comment_id: patrick_comment.id,
    category: 'comment'
  }
]

Like.create(likes)