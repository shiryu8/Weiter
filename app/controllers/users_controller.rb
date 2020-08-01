class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :show]
  before_action :check_current_user?,only: [:edit, :update]

  def show
  	@user = User.find(params[:id])
  	@articles = current_user.articles
    #ユーザーがファボした投稿を取得する
    @favorite_articles = @user.favorite_articles
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

  def followsandfollowers
    @user = User.find(params[:id])
    @follow_users = @user.followings
    @follower_users = @user.followers
  end
  # def follows
  #   user = User.find(params[:id])
  #   @users = user.followings
  # end

  # def followers
  #   user = User.find(params[:id])
  #   @users = user.followers
  # end

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
