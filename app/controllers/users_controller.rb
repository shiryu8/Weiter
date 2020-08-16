class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :show]
  before_action :check_current_user?, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @articles = current_user.articles
    # ユーザーがファボした投稿を取得する
    @favorite_articles = @user.favorite_articles

    # DM機能
    # ログインしているユーザーとチャットをしたい相手ユーザーを探す
    @current_user_entry = Entry.where(user_id: current_user.id)
    @user_entry = Entry.where(user_id: @user.id)

    # ログインしているユーザーではない場合
    unless @user.id == current_user.id
      @current_user_entry.each do |cu|
        @user_entry.each do |u|
          # Entriesテーブル内にあるroom_idが共通しているユーザー同士の場合
          if cu.room_id == u.room_id
            @is_room = true
            @room_id = cu.room_id
          end
        end
      end
      # ルームが作成されていない場合
      unless @is_room
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def calendershow
    @user = User.find(params[:user_id])
    @events = Event.where(user_id: @user.id)
    @event = Event.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'ユーザー情報を編集しました。'
      redirect_to user_path
    else
      flash.now[:danger] = 'ユーザー情報の編集に失敗しました。'
      render :edit
    end
  end

  def followingsandfollowers
    @user = User.find(params[:id])
    @following_users = @user.followings
    @follower_users = @user.followers
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :goal)
  end

  def check_current_user?
    user = User.find_by(id: params[:id])
    if user != current_user
      redirect_to user_path(current_user)
    end
  end
end
