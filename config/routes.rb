Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'tops#top'
  get 'home/about', to: 'tops#about'

  resources :articles do
    resource :favorites, only: [:create, :destroy]
    post 'favorites/favoritescreate', to: 'favorites#favoritescreate'
    delete 'favorites/favoritesdestroy', to: 'favorites#favoritesdestroy'
    resources :post_comments, only: [:create, :destroy]
  end

  # ハッシュタグした投稿の一覧
  get '/article/hashtag/:name', to: 'articles#hashtag'

  # フォローしたユーザーの投稿一覧
  get 'following_articles', to: 'articles#following_articles'

  # サッカーノート作成ページ
  get 'soccer_note', to: 'articles#soccer_note', as: 'soccer_note'
  get 'articles/:id/soccer_note_edit', to: 'articles#soccer_note_edit', as: 'soccer_note_edit'
  get 'articles/:id/soccer_note_show', to: 'articles#soccer_note_show', as: 'soccer_note_show'

  resources :users, only: [:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    post 'relationships/followcreate', to: 'relationships#followcreate'
    delete 'relationships/followdestroy', to: 'relationships#followdestroy'
    # フォロワー一覧＋フォロー一覧
    get :followingsandfollowers, on: :member
    get 'event', to: 'users#calendershow'
  end

  resources :events, only: [:create, :update, :destroy]

  resources :messages, only: [:create]

  resources :rooms, only: [:create, :show]
end
