# DashboardController
class DashboardController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @posts = Post.order("#{sort_column} #{sort_direction}")
  end

  def profile
    @user = User.find_by(id: params[:id])
    if !@user.present?
      redirect_to root_path
    else
      @posts = @user.posts
    end
    @posts = @user.posts.order("#{sort_column} #{sort_direction}")
  end

  def show_user
    @users = User.all.paginate(page: params[:page], per_page: 3)
  end

  def search
    @posts = Post.all.where('title LIKE ? OR description LIKE ? ',
                            "%#{params[:search]}%", "%#{params[:search]}%")
  end

  private

  def user_params
    params[:user].permit(:email, :password, :name)
  end

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
