class AddOpentableToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :opentable, :string
  end
end
