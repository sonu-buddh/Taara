# model for the post
class Post < ApplicationRecord
  has_many :favorite_lists, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  belongs_to :user, class_name: 'User'

  acts_as_taggable_on :tags
end
