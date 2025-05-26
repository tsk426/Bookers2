class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:edit, :update, :destroy]

  before_action :authenticate_user! 
  before_action :check_book_owner, only: [:edit, :update, :destroy]

  def new
    @book = Book.new(book_params)
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
  end

  def create
    @book = current_user.books.new(book_params)
    @user = current_user
    if @book.save
    flash[:success] = "You have created book successfully."
    redirect_to @book
    else
    @books = Book.all
    flash[:error] = "can't be blank"
    render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = User.find(current_user.id)
  end

  def user_book
   @books = current_user.books
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:success] = "You have updated book successfully."
    redirect_to book_path(@book.id)
    else
    flash[:error] = "can't be blank"
    render :edit
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

end

private

  def book_params
    params.require(:book).permit(:title, :body ,:profile_image)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def check_book_owner
    @book = Book.find(params[:id])
    unless @book.user == current_user
      flash[:error] = 'You are not authorized.'
      redirect_to books_path
    end
  end