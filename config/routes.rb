Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'tops#top'

  resources :articles do
  	resource :favorites, only: [:create, :destroy]
      post 'favorites/favoritescreate', to: 'favorites#favoritescreate'
      delete 'favorites/favoritesdestroy', to: 'favorites#favoritesdestroy'
  	resources :post_comments, only: [:create, :destroy]
  end


  resources :users, only: [:show, :edit, :update] do
  	resource :relationships, only: [:create, :destroy]
      post 'relationships/followcreate', to: 'relationships#followcreate'
      delete 'relationships/followdestroy', to: 'relationships#followdestroy'
    #フォロワー一覧＋フォロー一覧
    get :followingsandfollowers, on: :member
  end
end
