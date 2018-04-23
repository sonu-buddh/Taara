# user model
class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :followinglists
  belongs_to :role

  def admin_role?
    role.name == 'admin'
  end

  def normal_user_role?
    role.name == 'normal_user'
  end

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

  def approved_request(user)
    a = FollowingList.requested.where('to_id = ? and from_id = ?',
                                      id, user.id)
    a[0].accepted!
  end

  def feedback(post_id)
    Feedback.find_by(user_id: id, post_id: post_id)
  end
end
