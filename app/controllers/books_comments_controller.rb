class BooksCommentsController < ApplicationController
	def create
		@book = Book.find(params[:book_id])
		@books_comment = BooksComment.new(books_comment_params)
		@books_comment.user_id = current_user.id
		@books_comment.book_id = @book.id
		@books_comment.save
		# redirect_to request.referer
	end
	def destroy
		@book = Book.find(params[:book_id])
		@books_comment = BooksComment.find(params[:id])
		@books_comment.user_id = current_user.id
		@books_comment.book_id = @book.id
		@books_comment.destroy
		# redirect_to request.referer
	end

	def edit
		@comment = BooksComment.find(params[:id])
		@book = Book.find(params[:book_id])
	end

	def update
		@comment = BooksComment.find(params[:id])
		@comment.update(books_comment_params)
		redirect_to book_path(@comment.book.id)
	end

	private
	def books_comment_params
		params.require(:books_comment).permit(:comment)
	end
end
