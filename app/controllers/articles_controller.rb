class ArticlesController < ApplicationController
  before_action :current_user_available, only: %i[new create]
  before_action :set_article, only: %i[show edit update destroy]

  def index
    @articles = Article.all
  end

  def show; end

  def new
    @article = Article.new
  end

  def edit; end

  def create
    # @article = Article.new(article_params)
    # @article.user_id = current_user.id
    @article = current_user.articles.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path, status: :see_other
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def current_user_available
    return unless current_user.nil?

    flash[:notice] = 'You must be logged in to write an article'
    redirect_to articles_path
  end
end
