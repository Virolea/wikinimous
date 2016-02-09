class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def show
    renderer = Redcarpet::Render::HTML.new(render_options = {})
    @markdown = Redcarpet::Markdown.new(renderer, extensions = {})
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(user_params)
    @article.save

    redirect_to articles_path
  end

  def update
    @article.update(user_params)

    redirect_to article_path(@article)
  end

  def destroy
    @article.destroy

    redirect_to articles_path
  end

  private

  def user_params
    params.require(:article).permit(:title, :content)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
