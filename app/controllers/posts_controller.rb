class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
      flash[:success] = "投稿しました"
    else
      render :new 
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      redirect_to post_path(post)
      flash[:success] = "編集しました"
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to post_path
  end

  def hashtag
    @hashtag = Hashtag.find_by(hashname: params[:hashname])
    @posts = @hashtag.posts
  end

  private

  def post_params
    params.require(:post).permit(:title, :prefecture, :body, category_ids: [], post_images_images: [], hashtag_ids: [])
  end

end
