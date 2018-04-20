# this is for followers controller followinglist
class FollowsController < ApplicationController
  after_action :index, only: %i[follow_req approved delete_request
                                unfollow]

  def index
    fetch_records
  end

  def follow_req
    @request_to_id = params[:to_id]
    @checkcount = FollowingList.where(to_id: params[:to_id], from_id:
       current_user.id, follow_status: 'requested')
    if @checkcount.empty?
      followinglist = FollowingList.new(from_id: current_user.id, to_id:
         params[:to_id], follow_status: 'requested')
      followinglist.save!
    else
      render html: 'you already requested'
    end
    fetch_records
  end

  def approved
    @id = params[:from_id]
    request_user = User.find(@id)
    current_user.approved_request(request_user)
    fetch_records
  end

  def cancel_request
    @id = params[:from_id]
    cancel_req = FollowingList.find_by('to_id = ? and from_id = ?',
                                       current_user.id, params[:from_id])
    FollowingList.delete(cancel_req.id)
    fetch_records
  end

  def revert_request
    @id = params[:to_id]
    cancel_req = FollowingList.find_by('from_id = ? and to_id = ?',
                                       current_user.id, params[:to_id])
    FollowingList.delete(cancel_req.id)
    fetch_records
  end

  def unfollow

    unfollow_req = FollowingList.find_by('to_id = ? and from_id = ?',
                                         params[:to_id], current_user.id)
    FollowingList.delete(unfollow_req.id)
    redirect_to follows_path
    fetch_records
  end

  def followings_list
    @following = current_user.followings
                             .paginate(page: params[:page], per_page: 10)
    fetch_records
  end

  def followers_list
    @follower = current_user.followers
                            .paginate(page: params[:page], per_page: 10)
    fetch_records
  end

  private

  def fetch_records
    allusers = User.all
    @requested = current_user.requested_users
    @accepted = current_user.followings
    @users = allusers - @requested
  end
end
