class Choice < ActiveRecord::Base
  belongs_to :user
  belongs_to :search
  belongs_to :restaurant
end
