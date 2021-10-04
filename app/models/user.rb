class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    slug = self.username.strip.gsub(/![^a-zA-Z]/, "").gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    @user = User.all.find {|user| user.slug == slug }
  end
end
