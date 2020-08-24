class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only:[:edit, :update]

	def index
		@user = User.find(current_user.id)
		@users = User.all
		@book = Book.new
	end

	def show
		@user = User.find(params[:id])
		@books = Book.where(user_id: @user.id)
		@book = Book.new
	end

	def edit
		@user = User.find(current_user.id)
	end

	def update
		@books = Book.all
		@book = Book.new
		@user = User.find(current_user.id)
		if @user.update(user_params)
			flash[:notice] = "You have updated user successfully."
		    redirect_to user_path(@user.id)
		else
			render :edit
		end
	end

	private
	def user_params
		params.require(:user).permit(:name, :profile_image, :introduction)
	end

	def correct_user
		@user = User.find(params[:id])
		if @user != current_user
			redirect_to user_path(current_user.id)
		end	
	end
end
