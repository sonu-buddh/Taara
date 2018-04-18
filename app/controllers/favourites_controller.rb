# favourite the post
class FavouritesController < ApplicationController
  def fav_post
    @pid = params[:post_id]
    if current_user
      fav_list = FavoriteList.where(user_id: current_user.id,
                                    post_id: params[:post_id])
      if fav_list[0].nil?
        fav = FavoriteList.new(user_id: current_user.id,
                               post_id: params[:post_id])
        fav.save!
      else
        favourite = FavoriteList.find(fav_list[0].id)
        favourite.destroy
      end
    end
  end

  def fav_post_list
    @fav_list = FavoriteList.where(user: current_user)
  end
end
