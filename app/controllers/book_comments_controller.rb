class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    @comment.save
    flash.now[:notice] = "You have created comment successfully."
    @book_comment = BookComment.new
    render 'book_comments'
  end

  def destroy
    BookComment.find(params[:id]).destroy
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.new
    flash.now[:alert] = 'Deleted as requested'
    render 'book_comments'
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end