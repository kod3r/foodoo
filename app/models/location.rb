class Location < ActiveRecord::Base
  belongs_to :locator, polymorphic: true, touch: true
  geocoded_by :full_address
  after_validation :geocode

  def full_address
    self.address+' '+self.city+' '+self.state
  end

end
