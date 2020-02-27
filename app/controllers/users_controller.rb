class UsersController < ApplicationController
# https://qiita.com/hirokihello/items/a1ddf68d35f3cb7f2779 (名前でログイン)
	 before_action :configure_permitted_parameters, if: :devise_controller?
  	 before_action :authenticate_user!
	def show
		user = current_user
		@book = Book.new
		@user = User.find(params[:id])
		@books = @user.books
	end

	def index
		@users = User.page(params[:page]).reverse_order
		@book = Book.new
	end

	def edit
		@user = User.find(params[:id])
		# 下記の記述があるとif文の中の同じ記述の意味がなくなってしまう
		# @user.id = current_user.id
# もし@userがcurrent_userじゃ無い場合はリダイレクトするようにする
		if @user.id != current_user.id
			redirect_to user_path(current_user)
		end
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:notice] ="You have updated user successfully."
		redirect_to user_path
		else
			render :edit
		end
	end



	def follows
		@user = User.find(params[:id])
		
	end

	def followers
		user = User.find(params[:id])
		@users = user.followers
	end



	protected

	def configure_permitted_parameters
	   devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
	end

	private
	def user_params
		params.require(:user).permit(:name,:profile_image,:introduction)
 	end
 	# https://pikawaka.com/rails/before_action
 	def redirect_root
    redirect_to root_path unless user_signed_in?
    end


end
