class RemoveIpAdressFromRestaurants < ActiveRecord::Migration
  def change
    remove_column :restaurants, :ip_address, :string
  end
end
