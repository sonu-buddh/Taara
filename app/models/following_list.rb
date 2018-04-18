# model FollowingList
class FollowingList < ApplicationRecord
  enum follow_status: %i[accepted requested]
  belongs_to :to, class_name: 'User'
  belongs_to :from, class_name: 'User'
end
