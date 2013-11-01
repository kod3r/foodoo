class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.integer :user_id
      t.string :method_filter
      t.string :cuisine_filter
      t.string :price_filter
      t.integer :members
      t.time :time
      t.date :date
      t.string :ip_address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
