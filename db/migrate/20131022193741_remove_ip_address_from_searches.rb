class RemoveIpAddressFromSearches < ActiveRecord::Migration
  def change
    remove_column :searches, :ip_address, :string
  end
end
