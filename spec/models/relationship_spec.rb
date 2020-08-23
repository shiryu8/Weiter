require 'rails_helper'

RSpec.describe 'Relationshipモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'Followingモデルとの関係' do
      it 'N:1となっている' do
        expect(Relationship.reflect_on_association(:following).macro).to eq :belongs_to
      end
    end

    context 'Followerモデルとの関係' do
      it 'N:1となっている' do
        expect(Relationship.reflect_on_association(:follower).macro).to eq :belongs_to
      end
    end
  end
end
