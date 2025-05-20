class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:destroy]


  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)  
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
  end

  def user_book
   @books = current_user_books 
  end

  def update
    @book = Book.new
    if @book.save
    redirect_to book_path(@book.id)
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def destroy
    @book.destroy
    redirect_to books_path(@book.id)
  end

end

private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def set_book
    @book = Book.find(params[:id])
  end
