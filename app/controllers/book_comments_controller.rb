class BookCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.new(book_comment_params)
    @book_comment.book_id = @book.id
    @book_comment.user_id = current_user.id

    respond_to do |format|
      if @book_comment.save
        format.html { redirect_back fallback_location: books_path }
        format.js
      else
        format.html { render 'error' }
        format.js { render 'error' }
      end
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.find(params[:id])
    @book_comment.destroy

    respond_to do |format|
      format.html { redirect_back fallback_location: books_path }
      format.js
    end
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end