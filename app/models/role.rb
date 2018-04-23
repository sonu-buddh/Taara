# create user roles
class Role < ApplicationRecord
  has_many :users
end
