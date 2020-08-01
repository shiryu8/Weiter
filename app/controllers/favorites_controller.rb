class FavoritesController < ApplicationController
  def create
  	article = Article.find(params[:article_id])
    favorite = current_user.favorites.new(article_id: article.id)
    favorite.save
    redirect_to articles_path
  end

  def destroy
  	article = Article.find(params[:article_id])
    favorite = current_user.favorites.find_by(article_id: article.id)
    favorite.destroy
    redirect_to articles_path
  end

  def favoritescreate
    article = Article.find(params[:article_id])
    favorite = current_user.favorites.new(article_id: article.id)
    favorite.save
    redirect_to article_path(params[:article_id])
  end

  def favoritesdestroy
    article = Article.find(params[:article_id])
    favorite = current_user.favorites.find_by(article_id: article.id)
    favorite.destroy
    redirect_to article_path(params[:article_id])
  end
end
