# create ability for user class
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in
    if user.admin_role?
      can :manage, :all
      can :dashboard
      can :manage, User, Post
      # Always performed
      can :access, :ckeditor # needed to access Ckeditor filebrowser
      can :edit, User
      # Performed checks for actions:
      can %i[read create destroy], Ckeditor::Picture
      can %i[read create destroy], Ckeditor::AttachmentFile

    end
    if user.normal_user_role?
      can %i[read create], Post
      can %i[update destroy], Post, user_id: user.id
      # Always performed
      can :access, :ckeditor # needed to access Ckeditor filebrowser
      can %i[update destroy], User, user_id: user.id      # Performed checks for actions:
      can %i[read create destroy], Ckeditor::Picture
      can %i[read create destroy], Ckeditor::AttachmentFile
    end
  end

  # Define abilities for the passed in user here. For example:
  #
  #   user ||= User.new # guest user (not logged in)
  #   if user.admin?
  #     can :manage, :all
  #   else
  #     can :read, :all
  #   end

  #
  # The first argument to `can` is the action you are giving the
  # user
  # permission to do.
  # If you pass :manage it will apply to every action. Other
  # common actions
  # here are :read, :create, :update and :destroy.
  #
  # The second argument is the resource the user can perform
  # the action on.
  # If you pass :all it will apply to every resource. Otherwise
  # pass a Ruby
  # class of the resource.
  #
  # The third argument is an optional hash of conditions to
  # further filter the
  # objects.
  # For example, here the user can only update published
  # articles.
  #
  #   can :update, Article, :published => true
  #
  # See the wiki for details:
  # https://github.com/CanCanCommunity/cancancan/wiki/Defining
  # -Abilities
end
