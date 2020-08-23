require 'rails_helper'

describe 'ヘッダーのテスト' do
  describe 'ログインしていない場合' do
    before do
      visit root_path
    end

    context 'ヘッダーの表示を確認' do
      subject { page }

      it 'タイトルが表示される' do
        is_expected.to have_content 'Weiter'
      end
    end

    context 'ヘッダーのリンクを確認' do
      subject { current_path }

      it 'トップ画面に遷移する' do
        expect(page).to have_link "", href: root_path
      end
      it 'About画面に遷移する' do
        expect(page).to have_link "", href: home_about_path
      end
      it '新規登録画面に遷移する' do
        expect(page).to have_link "", href: new_user_registration_path
      end
      it 'ログイン画面に遷移する' do
        expect(page).to have_link "", href: new_user_session_path
      end
    end
  end

  describe 'ログインしている場合' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log In'
    end

    context 'ヘッダーの表示を確認' do
      subject { page }

      it 'タイトルが表示される' do
        is_expected.to have_content 'Weiter'
      end
    end

    context 'ヘッダーのリンクを確認' do
      subject { current_path }

      it 'Articles画面に遷移する' do
        expect(page).to have_link "", href: articles_path
      end
      it 'Following_articles画面に遷移する' do
        expect(page).to have_link "", href: following_articles_path
      end
      it 'プロフィール画面に遷移する' do
        expect(page).to have_link "", href: user_path(user)
      end
      it 'Calendar画面に遷移する' do
        expect(page).to have_link "", href: user_event_path(user)
      end
      it '新規投稿画面に遷移する' do
        expect(page).to have_link "", href: new_article_path
      end
    end
  end
end
