class RelationshipsController < ApplicationController

  def follow
    current_user.follow(params[:id])
    redirect_back(fallback_location: users_path)
  end

  def unfollow
    current_user.unfollow(params[:id])
    redirect_back(fallback_location: users_path)
  end

  def follower
    @user = User.find(params[:id])
    @users = @user.following_user
  end

  def followed
    @user = User.find(params[:id])
    @users = @user.follower_user
  end
end
