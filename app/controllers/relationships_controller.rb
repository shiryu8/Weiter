class RelationshipsController < ApplicationController
  def create
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    follow.save
    redirect_to user_path(params[:user_id])
  end

  def destroy
    follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
    follow.destroy
    redirect_to user_path(params[:user_id])
  end

  def followcreate
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    follow.save
    redirect_to followingsandfollowers_user_path(current_user.id)
  end

  def followdestroy
    follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
    if follow.present?
      follow.destroy
    end
    redirect_to followingsandfollowers_user_path(current_user.id)
  end
end
