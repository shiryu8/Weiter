require 'rails_helper'

RSpec.describe 'Hashtagモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:hashtag) { build(:hashtag)}

  	context 'hashnameカラム' do
  	  it '空欄でないこと' do
        hashtag.hashname = ''
        expect(hashtag.valid?).to eq false;
      end
      it '50文字以下であること' do
        hashtag.hashname = Faker::Lorem.characters(number:51)
        expect(hashtag.valid?).to eq false
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Articleモデルとの関係' do
      it '1:Nとなっている' do
        expect(Hashtag.reflect_on_association(:articles).macro).to eq :has_many
      end
    end
    context 'HashtagArticleモデルとの関係' do
      it '1:Nとなっている' do
        expect(Hashtag.reflect_on_association(:hashtag_articles).macro).to eq :has_many
      end
    end
  end
end