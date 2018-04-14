# user model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :followinglists

  def search_users(name)
    User.where('name LIKE ?', "#{name.capitalize}%") -
      (User.where(id: blocked_users) + [self])
  end

  # def blocked_by_me
  #   User.where(id: FollowingList.blocked.where(from_id: id).pluck(:to_id))
  # end

  # def blocked_by_whom
  #   User.where(id: FollowingList.blocked.where(to_id: id).pluck(:from_id))
  # end

  # def blocked_users
  #   (blocked_by_me + blocked_by_whom).uniq
  # end

  def followers
    User.where(id: FollowingList.where(to_id: id).accepted.pluck(:from_id))
  end

  def followings
    User.where(id: FollowingList.where(from_id: id).accepted.pluck(:to_id))
  end

  def requested_users
    User.where(id: FollowingList.where(to_id: id).requested.pluck(:from_id))
  end

  def requested_by_me?(user)
    FollowingList.where(from_id: id, to_id: user.id, follow_status: 'requested')
                 .present?
  end
end
