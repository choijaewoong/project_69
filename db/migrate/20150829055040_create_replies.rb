class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.string :context
      t.integer :like_count
      t.integer :user_id
      t.integer :post_id

      t.timestamps null: false
    end
  end
end
