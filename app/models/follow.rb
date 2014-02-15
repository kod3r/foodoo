class Follow < ActiveRecord::Base
  belongs_to :follower, class_name: "User", touch: true
  belongs_to :followed, class_name: "User", touch: true
end
