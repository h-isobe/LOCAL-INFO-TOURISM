class SearchController < ApplicationController
  before_action :authenticate_user!

  def search
    @content = params["search"]["content"]
    @model = params["search"]["model"]
    @records = search_for

    if @model == 'user'
      @users = @records.page(params[:page])
    else @model == 'post'
      @posts = @records.page(params[:page])
    end
  end   
  
  private
  
  def search_for
    if @model == 'user'
      keyword_user_name
    else @model == 'post'
      keyword_post_body
    end
  end

  def keyword_user_name
    User.where('name LIKE ?' , "%#{@content}%")
  end

  def keyword_post_body
    Post.where('body LIKE ?' , "%#{@content}%")
  end

end
