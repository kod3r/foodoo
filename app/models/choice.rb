class Choice < ActiveRecord::Base
  belongs_to :user, touch: true
  belongs_to :search, touch: true
  belongs_to :restaurant, touch: true
end
