class RemoveLatitudeFromSearches < ActiveRecord::Migration
  def change
    remove_column :searches, :latitude, :float
  end
end
