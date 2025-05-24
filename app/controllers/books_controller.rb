class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:destroy]

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
    if @book.save
    redirect_to book_path(@book.id)
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
    @book.update(book_params)
    redirect_to book_path(@book.id)
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
    params.require(:book).permit(:title, :body ,:image)
  end

  def set_book
    @book = Book.find(params[:id])
  end
