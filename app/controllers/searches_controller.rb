class SearchesController < ApplicationController
  before_action :require_authentication

  def search
    @range = params[:range]
    @word = params[:word]
    @search = params[:search]

    if @range == "User"
      @records = User.looks(@search, @word)
    else
      @records = Post.looks(@search, @word)
    end
  end

end
