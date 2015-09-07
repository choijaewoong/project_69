class CreateLikeReplies < ActiveRecord::Migration
  def change
    create_table :like_replies do |t|
      
      t.integer :user_id
      t.integer :reply_id

      t.timestamps null: false
    end
  end
end
