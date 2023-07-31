class CommentsController < ApplicationController
  before_action :current_user_available, only: %i[new create]

  # def new
  #   @comment = Comment.new
  # end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to article_path(@article)
    else
      p @article.errors
      p @comment.errors
      flash[:notice] = 'Body cannot be empty'
      render @article, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    render @article, status: :unprocessable_entity
  end

  private

  def current_user_available
    return unless current_user.nil?

    flash[:notice] = 'You must be logged in to write a comment'
    redirect_to article_path(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :status)
  end
end
