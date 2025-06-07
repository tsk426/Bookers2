class BookCommentsController < ApplicationController


  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    if @comment.save
      @book_comment = BookComment.new
      respond_to do |format|
        format.js 
      end
    end
  end

  def destroy
    @comment = BookComment.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      respond_to do |format|
        format.js
      flash[:success] = "コメントを削除しました"
    end
    else
      flash[:error] = "他人のコメントは削除できません"
    end
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end


end
