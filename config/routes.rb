Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :articles do
  	resource :favorites, only: [:create, :destroy]
  	resources :post_comments, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update] do
  	resource :relationships, only: [:create, :destroy]
    post 'relationships/followcreate', to: 'relationships#followcreate'
    delete 'relationships/followdestroy', to: 'relationships#followdestroy'
  	# #フォロー一覧
   #  get :follows, on: :member
   #  #フォロワー一覧
   #  get :followers, on: :member

    #フォロワー一覧＋フォロー一覧
    get :followsandfollowers, on: :member
  end
end
