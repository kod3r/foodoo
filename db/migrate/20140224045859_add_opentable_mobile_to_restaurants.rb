class AddOpentableMobileToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :opentable_mobile, :string
  end
end
