# 代码生成时间: 2025-08-26 04:38:55
# Test Data Generator Sinatra application
#
# This application generates random test data for various purposes.
# It follows the Ruby best practices and is designed to be
# maintainable and extensible.

class TestDataGenerator < Sinatra::Base
  # Set a route to generate random user data
  get '/user' do
    # Generate a random user hash
    user = {
      id: rand(1..1000),
      name: Faker::Name.name,
      email: Faker::Internet.email,
      age: rand(18..65)
    }
    # Return the user data as JSON
    content_type :json
    user.to_json
  end

  # Set a route to generate random post data
  get '/post' do
    # Generate a random post hash
    post = {
      id: rand(1..1000),
      title: Faker::Lorem.sentence(word_count: 5),
      content: Faker::Lorem.paragraph,
      author_id: rand(1..1000)
    }
    # Return the post data as JSON
    content_type :json
    post.to_json
  end

  # Handle errors with a custom 404 page
  not_found do
    'This resource could not be found.'
  end
end

# Require the Faker library for generating fake data
require 'faker'

# Run the Sinatra application
run! if app_file == $0