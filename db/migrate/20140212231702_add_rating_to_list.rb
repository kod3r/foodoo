class AddRatingToList < ActiveRecord::Migration
  def change
    add_column :lists, :rating, :int, default: "new"
  end
end
