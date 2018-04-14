Rails.application.routes.draw do
  root to: 'dashboard#index'
  resources :dashboard, only: [:index]
  resources :post, only: %i[new create show edit update destroy]
  resources :tags, only: %i[index show]

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    account_update: 'users/registrations'
  }

  devise_scope :user do
    get 'show_user', to: 'dashboard#show_user'

    get 'show', to: 'post#show'
    post 'show', to: 'post#show'
    get  'user/:id/profile', to: 'dashboard#profile', as: 'profile_user'
    get 'favourites/fav_post', to: 'favourites#fav_post', as: 'favourite_post'
    post 'favourites/fav_post'
    get 'favourites/fav_post_list'
    post 'favourites/fav_post_list'
    post 'feedbacks/like'
    get  'dashboard/search'

    get 'follows', to: 'follows#index'

    post 'follows', to: 'follows#follow_req'
    put 'approved', to: 'follows#approved'
    delete 'cancel', to: 'follows#cancel_request'
    delete 'revert', to: 'follows#revert_request'
    delete 'unfollow', to: 'follows#unfollow'
    post 'block', to: 'follows#blockuser'
    get 'follows/search', to: 'follows#search'
    get 'followings', to: 'follows#followings_list'
    get 'followers', to: 'follows#followers_list'
    delete 'follows/unblockuser'
  end
end
