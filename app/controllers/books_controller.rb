class BooksController < ApplicationController
  before_action :authenticate_user!

  def show
    @book = Book.find(params[:id])
    @books = current_user.books
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
    redirect_to users_home_path
    end
  end

  def index
    @books = Book.all
  end

end

private

def book_params
  params.require(:book).permit(:title, :body)
end