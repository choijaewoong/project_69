class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      
      t.integer :grade, default: 3
      t.string :description

      t.timestamps null: false
    end
  end
end
