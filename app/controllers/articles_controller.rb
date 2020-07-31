class ArticlesController < ApplicationController
	before_action :authenticate_user!
    before_action :current_user_book?, only: [:edit, :update, :destroy]

	def new
		@article_new = Article.new
	end

	def create
		@article_new = Article.new(article_params)
		@article_new.user_id = current_user.id

		if @article_new.save
			redirect_to articles_path(@article_new.id)
		else
			render :new
		end
	end

	def index
		@articles = Article.all
	end

	def show
		@article = Article.find(params[:id])
		@user = @article.user
		@post_comment = PostComment.new
	end

	def edit
		@article = Article.find(params[:id])
	end

	def updete
		@article = Article.find(params[:id])
		if @article.update(article_params)
			redirect_to articles_path(@article.id)
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
				params.require(:article).permit(:title, :content, :image, :user_id)
			end
		end
