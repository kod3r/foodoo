class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.integer :user_id
      t.integer :restaurant_id
      t.string :label

      t.timestamps
    end
  end
end
