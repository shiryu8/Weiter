class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :current_user_article?, only: [:edit, :update, :destroy]

  def new
    @article_new = Article.new
  end

  def create
    @article_new = Article.new(article_params)
    @article_new.user_id = current_user.id

    if @article_new.save
      redirect_to articles_path
    else
      render :new
    end
  end

  def index
    @articles = Article.search(params[:search]).order("created_at DESC")
    @all_ranks = Article.find(@articles.get_topthree_article_id)
    @hashtags = Hashtag.all.to_a.group_by { |hashtag| hashtag.articles.count }
  end

  def following_articles
    @user = current_user
    @users = @user.followings.order("created_at DESC")
  end

  def show
    @article = Article.find(params[:id])
    @user = @article.user
    @post_comment = PostComment.new
  end

  def hashtag
    @user = current_user
    @hashtag = Hashtag.find_by(hashname: params[:name])
    @article = @hashtag.articles.all
    @hashtags = Hashtag.all.to_a.group_by { |hashtag| hashtag.articles.count }
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :image, :user_id, :hashbody, hashtag_ids: [])
  end

  def current_user_article?
    article = Article.find(params[:id])
    if article.user_id != current_user.id
      redirect_to articles_path
    end
  end
end
