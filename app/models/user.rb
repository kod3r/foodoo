class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :lists
  has_many :restaurants, through: :lists
  has_many :followers, :class_name => 'Follows', :foreign_key => 'followed_id'
  has_many :following, :class_name => 'Follows', :foreign_key => 'follower_id'
  has_many :searches
  has_many :choices
  has_many :locations, as: :locator

end
