require 'rails_helper'

RSpec.describe 'HashtagArticleモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'Articleモデルとの関係' do
      it 'N:1となっている' do
        expect(HashtagArticle.reflect_on_association(:article).macro).to eq :belongs_to
      end
    end

    context 'Hashtagモデルとの関係' do
      it 'N:1となっている' do
        expect(HashtagArticle.reflect_on_association(:hashtag).macro).to eq :belongs_to
      end
    end
  end
end
