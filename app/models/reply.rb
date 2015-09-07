class Reply < ActiveRecord::Base
    has_many :like_replies
    belongs_to :user
    belongs_to :post
end
