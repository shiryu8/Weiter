class TopsController < ApplicationController
  def top
	@articles = Article.all
  end
end
