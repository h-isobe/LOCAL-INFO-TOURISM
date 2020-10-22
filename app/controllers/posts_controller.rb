class PostsController < ApplicationController
  before_action :authenticate_user!
  impressionist :actions=> [:show]


  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
      flash[:notice] = "投稿しました"
    else
      render :new 
    end
  end

  def index
    @posts = Post.page(params[:page]).reverse_order
    @all_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(5).pluck(:post_id))
    @categories = Category.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    impressionist(@post)
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @post.user.id)
    unless @post.user.id == current_user.id
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
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
      flash[:notice] = "編集しました"
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
    flash[:notice] = "投稿を削除しました"
  end

  def hashtag
    @hashtag = Hashtag.find_by(hashname: params[:hashname])
    @posts = @hashtag.posts.page(params[:page]).reverse_order
    @hashtags = Hashtag.all
  end

  def category
    @category = Category.find_by(name: params[:name])
    @posts = @category.posts.page(params[:page]).reverse_order
    @categories = Category.all
  end

  def prefecture
    @prefecture_posts = Post.where(prefecture: params[:prefecture])
  end

  def map
    
  end
  

  private

  def post_params
    params.require(:post).permit(:title, :prefecture, :body, category_ids: [], post_images_images: [], hashtag_ids: [])
  end

end
