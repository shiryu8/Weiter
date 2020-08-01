class RelationshipsController < ApplicationController
  def create
  	follow = current_user.active_relationships.build(follower_id: params[:user_id])
    follow.save
    redirect_to user_path(params[:user_id])
  end

  def destroy
  	follow = current_user.active_relationships.find_by(follower_id: params[:user_id]).destroy
    redirect_to user_path(params[:user_id])
  end

  def followcreate
  	follow = current_user.active_relationships.build(follower_id: params[:user_id])
    follow.save
    redirect_to followsandfollowers_user_path(params[:user_id])
  end

  def followdestroy
  	follow = current_user.active_relationships.find_by(follower_id: params[:user_id]).destroy
    redirect_to followsandfollowers_user_path(params[:user_id])
  end
end