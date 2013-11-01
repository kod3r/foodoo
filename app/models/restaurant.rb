class Restaurant < ActiveRecord::Base
  has_many :lists
  has_many :choices
  has_many :users, through: :lists
  has_many :locations, as: :locator
end
