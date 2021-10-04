# Add seed data here. Seed your database with `rake db:seed`
users_list = {
    "username1" => {
      :email => "username1@mail.com",
      :password => "password"
    },
    "username2" => {
      :email => "user2@mail.com",
      :password => "password"
    }
  }

users_list.each do |username, users_hash|
  p = User.new
  p.username = username
  p.email = users_hash[:email]
  p.password = users_hash[:password]
  p.save
end

tweets_list = {
    "tweet content 1" => {
        :user_id => 1
    },
    "tweet content 2" => {
        :user_id => 2
    }
  }

tweets_list.each do |content, tweets_hash|
    p = Tweet.new
    p.content = content
    tweets_hash.each do |attribute, value|
        p[attribute] = value
    end
    p.save
end

