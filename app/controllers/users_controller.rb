class UsersController < ApplicationController

  def home
    @user = current_user
    @books = Book.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
    redirect_to users_home_path
    end
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if current_user.update(user_params)
    redirect_to users_home_path
    end
  end

end