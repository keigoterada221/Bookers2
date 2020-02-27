class SearchesController < ApplicationController
  def search
  	#binding.pry
  	@book = Book.new
  	if params[:search_select] == "1"
  	@users = User.search(params[:search],params[:word_search]).page(params[:page]).reverse_order
  	elsif params[:search_select] == "2"
  	@books = Book.search(params[:search],params[:word_search]).page(params[:page]).reverse_order
  	end
  end


end
