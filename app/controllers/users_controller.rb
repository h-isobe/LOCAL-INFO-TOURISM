class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, {only: [:edit]}

  def index
    @users = User.page(params[:page]).reverse_order
    @all_ranks = Post.find(Bookmark.group(:post_id).order('count(post_id) desc').limit(5).pluck(:post_id))
    @categories = Category.all
  end

  def show
    @user = User.find(params[:id])
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then #ルームが作成済みかどうかの条件分岐
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
    @posts = @user.posts.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:notice] = "編集しました"
    else
      render :edit
    end
  end

  def favorite
    @user = User.find(params[:id])
    @favorites = Favorite.where(user_id: @user.id)
  end

  def bookmark
    @user = User.find(params[:id])
    @bookmarks = Bookmark.where(user_id: @user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

end
