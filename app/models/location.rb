class Location < ActiveRecord::Base
  belongs_to :locator, polymorphic: true
  geocoded_by :address
  after_validation :geocode

end
