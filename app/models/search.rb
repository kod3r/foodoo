class Search < ActiveRecord::Base
  belongs_to :user
  has_many :locations, as: :locator
end
