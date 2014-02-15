class List < ActiveRecord::Base
  belongs_to :restaurant, touch: true
  belongs_to :user, touch: true
end
