class Post < ActiveRecord::Base
    has_many :replies
    has_many :like_posts
    belongs_to :user
    belongs_to :board
end
