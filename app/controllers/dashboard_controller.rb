# DashboardController
class DashboardController < ApplicationController
  helper_method :sort_column, :sort_direction

  # load_and_authorize_resource

  def index
    @pd = params[:post_id]
    @posts = Post.order("#{sort_column} #{sort_direction}")
                 .paginate(page: params[:page], per_page: 5)
                 .order('created_at DESC')
  end

  def profile
    @user = User.find_by(id: params[:id])
    if @user.blank?
      redirect_to root_path
    else
      @posts = @user.posts.order("#{sort_column} #{sort_direction}")
    end
  end

  def show_user
    @users = User.all.paginate(page: params[:page], per_page: 5)
  end

  def search
    @posts = Post.all.where('title LIKE ? OR description LIKE ? ',
                            "%#{params[:search]}%", "%#{params[:search]}%")
                 .paginate(page: params[:page], per_page: 3).present?
  end

  private

  # def user_params
  #   params[:user].permit(:email, :password, :name, :page)
  # end

  def sortable_columns
    ['created_at']
  end

  def sort_column
    sortable_columns.include?(params[:column]) ? params[:column] : 'created_at'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
