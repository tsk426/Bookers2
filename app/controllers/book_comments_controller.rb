class BookCommentsController < ApplicationController


  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
    redirect_to book_path(book)
  end

  def destroy
    comment = BookComment.find(params[:id])
    if comment.user == current_user
      comment.destroy
      flash[:success] = "コメントを削除しました"
    else
      flash[:error] = "他人のコメントは削除できません"
    end
    redirect_back fallback_location: root_path
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end


end
