class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new 
  end

  def new
    @book = Book.new
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def edit
    is_matching_login_user
    @user = User.find(params[:id])
  end

  def update
    is_matching_login_user
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:success] = "You have updated user infomation successfully."
    redirect_to user_path(@user.id)
    else
    flash[:error] = "Your name is too short (minimum is 2 characters)"
    render :edit
    end
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.following 
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers 
  end
  


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
    redirect_to user_path(current_user.id)
    end
  end

end