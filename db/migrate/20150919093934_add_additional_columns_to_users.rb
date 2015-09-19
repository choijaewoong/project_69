class AddAdditionalColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :born_year, :date
    add_column :users, :birthday, :date
    add_column :users, :animal_sign, :string
    add_column :users, :zodiac_sign, :string
  end
end
