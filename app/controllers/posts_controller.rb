class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create

  end

  def index

  end

  def show

  end

  def edit

  end

  def update

  end

  def destroy
    
  end
end
