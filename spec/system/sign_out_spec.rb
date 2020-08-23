require 'rails_helper'

RSpec.describe "Remember me", type: :request do
  let(:user) { FactoryBot.create(:user) }

  context "ログアウトする" do
    it "ログイン中のみログアウトすること" do
      delete destroy_user_session_path
      expect(response).to redirect_to root_path
      expect(session[:user_id]).to eq nil
    end
  end
end
