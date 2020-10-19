class SearchController < ApplicationController
  before_action :authenticate_user!

  def search
    @content = params["search"]["content"]
    @model = params["search"]["model"]
    @method = params["search"]["method"]
    @records = search_for
    #binding.pry
    #if @records == 
     #@posts = @records.page(params[:page])
    #else @records == 'user'
      #@users = @records.page(params[:page])
    #end
    if @model == 'user'
      @users = @records.page(params[:page])
    else @model == 'post'
      @posts = @records.page(params[:page])
    end
  end   
  
  private
  
  def search_for
    if @model == 'user'
      partial_or_perfect_match_user_name
    else @model == 'post'
      partial_or_perfect_match_post_body
    end
  end

  def partial_or_perfect_match_user_name
    if search_type_perfect_match?
      User.where(name: @content)
      #User.search_by_name(@content)
    else 
      User.where('name LIKE ?' , "%#{@content}%")
    end
  end

  def partial_or_perfect_match_post_body
    if search_type_perfect_match?
      Post.where(body: @content)
    else 
      Post.where('body LIKE ?' , "%#{@content}%")
    end
  end

  def search_type_perfect_match?
    @method == 'perfect'
  end
end
