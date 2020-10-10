class SearchController < ApplicationController

  before_action :authenticate_user!

  def search
    @content = params["search"]["content"]
    @model = params["search"]["model"]
    @method = params["search"]["method"]
    @records = search_for(@content, @model, @method)
  end
  
  private
  
  def search_for(content, model, method)
    if model == 'user'
      if method == 'perfect'
        User.where(name: content)
      else
        User.where('name LIKE ?' , '%'+content+'%' )
      end
    elsif model == 'post'
      if method == 'perfect'
        Post.where(body: content)
      else
        Post.where('body LIKE ?' , '%'+content+'%' )
      end
    else model == "prefecture"
      if method == 'perfect'
        Post.where(prefecture: content)
      else
        Post.where('prefecture LIKE ?' , '%'+content+'%' )
      end
    end
  end
end
