module ArticlesHelper
	def render_with_hashtags(hashbody)
		hashbody.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) { |word| link_to word, "/article/hashtag/#{word.delete("#")}" }.html_safe
  	end
end
