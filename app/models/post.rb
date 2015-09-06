class Post < ActiveRecord::Base
    has_many :reply
    has_many :like_posts
    belongs_to :user
end
