class Search < ActiveRecord::Base
  belongs_to :user, touch: true
  has_many :locations, as: :locator
end
