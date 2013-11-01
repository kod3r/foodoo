class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.integer :user_id
      t.integer :search_id
      t.integer :restaurant_id
      t.string :action

      t.timestamps
    end
  end
end
