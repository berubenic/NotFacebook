FactoryBot.define do
  factory :user do
    first_name { 'firstName' }
    last_name { 'lastName' }
    sequence(:email) { |n| "#{n}@email.com" }
    password { 'somehardcorepassword1234' }
  end

  factory :friendship do
    user
    association :friend, factory: :user
    confirmed { false }
  end

  factory :post do
    user
    body { 'I am a body' }
  end

  factory :comment do
    user
    post
    body { 'I am a comment' }
  end

  factory :like do
    user
    post
    category { 'post' }
  end
end
