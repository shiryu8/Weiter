class TopsController < ApplicationController
  def top
	@articles = Article.all
	#いいね順に投稿をランキング形式
	@all_ranks = Article.find(Favorite.group(:article_id).order('count(article_id) desc').limit(3).pluck(:article_id))
  end

  def about
  end
end
