class RemoveLongitudeFromSearches < ActiveRecord::Migration
  def change
    remove_column :searches, :longitude, :float
  end
end
