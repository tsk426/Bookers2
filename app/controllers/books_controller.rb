class BooksController < ApplicationController
  before_action :authenticate_user!

  def new
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @books = current_user.books
  end

  def create
    @book = current_user.books.new(book_params)
    if @book.save
    redirect_to book_path
    end
  end

  def index
    @books = Book.all
  end

  def user_book
   @books = current_user_books 
  end

end

private

def book_params
  params.require(:book).permit(:title, :body)
end