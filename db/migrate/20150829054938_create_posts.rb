class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      
      t.integer :user_id
      t.integer :board_id
      
      t.string :context
      t.integer :color
      t.integer :like_count
      
      t.timestamps null: false
    end
  end
end
