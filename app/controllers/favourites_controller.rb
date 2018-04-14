# favourite the post
class FavouritesController < ApplicationController
  def fav_post
    @pid = params[:post_id]
    if current_user
      a = FavoriteList.where(user_id: current_user.id, post_id: params[:post_id])
      if a[0].nil?
        fav = FavoriteList.new
        fav.user_id = current_user.id
        fav.post_id = params[:post_id]
        fav.save!
      else
        favourite = FavoriteList.find(a[0].id)
        favourite.destroy
      end
    end
  end

  def fav_post_list
    @fav_list = FavoriteList.where(user: current_user)
 end

  private

  def fav_posts
    post = FavoriteList.where(user_id: current_user.id).pluck(:post_id)
    Post.where(id: post)
 end
end
