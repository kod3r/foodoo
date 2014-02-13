class AddRatingToList < ActiveRecord::Migration
  def change
    add_column :lists, :rating, :int, default: 0
  end
end
