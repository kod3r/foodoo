class AddHoodToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :hood, :string
  end
end
