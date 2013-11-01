class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.references :locator, polymorphic: true
      t.string :address
      t.string :ip_address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
