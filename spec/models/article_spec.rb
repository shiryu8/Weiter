require 'rails_helper'

RSpec.describe 'Articleモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:article) { build(:article) }

    context 'titleカラム' do
      it '空欄でないこと' do
        article.title = ''
        expect(article.valid?).to eq false
      end
    end

    context 'contentカラム' do
      it '空欄でないこと' do
        article.content = ''
        expect(article.valid?).to eq false;
      end
    end

    context 'imageカラム' do
      it '空欄でないこと' do
        article.image = ''
        expect(article.valid?).to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Article.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(Article.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'PostCommentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Article.reflect_on_association(:post_comments).macro).to eq :has_many
      end
    end

    context 'HashtagArticleモデルとの関係' do
      it '1:Nとなっている' do
        expect(Article.reflect_on_association(:hashtag_articles).macro).to eq :has_many
      end
    end

    context 'Hashtagモデルとの関係' do
      it '1:Nとなっている' do
        expect(Article.reflect_on_association(:hashtags).macro).to eq :has_many
      end
    end
  end
end
