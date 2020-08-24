class BooksController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_book_user, only:[:edit, :update]

	def index
		@books = Book.all
		@book = Book.new
		@user = User.find(current_user.id)
	end

	def show
		@book = Book.find(params[:id])
		@book_new = Book.new
		@user = User.find(@book.user_id)
	end

	def new
		@book = Book.new
	end

	def create
		@user = User.find(current_user.id)
		@books = Book.all
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
			flash[:notice] = "You have creatad book successfully."
		    redirect_to book_path(@book.id)
		else
			render action: :index
		end	
	end

	def edit
		@user = User.find(current_user.id)
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		
		if @book.update(book_params)
			flash[:notice] = "You have updated book successfully."
		    redirect_to book_path(@book.id)
		else
			render action: :edit
		end
	end

	def destroy
		book = Book.find(params[:id])
		book.destroy
		redirect_to books_path
	end

	private
	def book_params
		params.require(:book).permit(:title, :body, :user_id)
	end
	def correct_book_user
		@book = Book.find(params[:id])
		if @book.user_id != current_user.id
			redirect_to books_path
		end
	end
end
