class PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.post_comments.new(post_comment_params)
    @comment.post_id = @post.id
    @comment.save
    @post.create_notification_post_comment!(current_user, @comment.id)
  end
  
  
  def destroy
    PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    @post = Post.find(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment, :user_id, :post_id)
  end
end
