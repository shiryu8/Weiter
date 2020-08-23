require 'rails_helper'
# require "refile/file_double"

describe '投稿のテスト' do
  let(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:article) { create(:article, user: user) }
  let!(:article2) { create(:article, user: user2) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log In'
  end

  describe '新規投稿のテスト' do
    before do
      visit new_article_path
    end

    context '表示の確認' do
      it 'New Postと表示される' do
        expect(page).to have_content 'New Post'
      end
      it 'titleフォームが表示される' do
        expect(page).to have_field 'article[title]'
      end
      it 'contentフォームが表示される' do
        expect(page).to have_field 'article[content]'
      end
      it 'hashtagフォームが表示される' do
        expect(page).to have_field 'article[hashbody]'
      end
      it 'Postボタンが表示される' do
        expect(page).to have_button 'Post'
      end
      it '投稿に成功する' do
        fill_in 'article[title]', with: Faker::Lorem.characters(number: 5)
        fill_in 'article[content]', with: Faker::Lorem.characters(number: 20)
        attach_file "article_image", "app/assets/images/arrow.png"
        click_button 'Post'
        expect(page).to have_content 'Articles'
      end
      it '投稿に失敗する' do
        click_button 'Post'
        expect(page).to have_content 'エラー'
        expect(current_path).to eq('/articles')
      end
    end
  end

  describe '投稿詳細画面のテスト' do
    context '自分・他人共通の投稿詳細画面の表示を確認' do
      it 'Articleと表示される' do
        visit article_path(article)
        expect(page).to have_content 'Article'
      end
      it 'ユーザーネームのリンク先が正しい' do
        visit article_path(article)
        expect(page).to have_link article.user.name, href: user_path(article.user)
      end
      it '投稿のtitleが表示される' do
        visit article_path(article)
        expect(page).to have_content article.title
      end
      it '投稿のcontentが表示される' do
        visit article_path(article)
        expect(page).to have_content article.content
      end
      it '投稿のhashtagが表示される' do
        visit article_path(article)
        expect(page).to have_content article.hashbody
      end
    end

    context '自分の投稿詳細画面の表示を確認' do
      it '投稿の編集リンクが表示される' do
        visit article_path article
        expect(page).to have_link 'Edit', href: edit_article_path(article)
      end
      it '投稿の削除リンクが表示される' do
        visit article_path article
        expect(page).to have_link 'Delete', href: article_path(article)
      end
    end

    context '他人の投稿詳細画面の表示を確認' do
      it '投稿の編集リンクが表示されない' do
        visit article_path(article2)
        expect(page).to have_no_link 'Edit', href: edit_article_path(article2)
      end
      it '投稿の削除リンクが表示されない' do
        visit article_path(article2)
        expect(page).to have_no_link 'Delete', href: article_path(article2)
      end
    end
  end

  describe '編集のテスト' do
    context '自分の投稿の編集画面への遷移' do
      it '遷移できる' do
        visit edit_article_path(article)
        expect(current_path).to eq('/articles/' + article.id.to_s + '/edit')
      end
    end

    context '表示の確認' do
      before do
        visit edit_article_path(article)
      end

      it 'Edit Articleと表示される' do
        expect(page).to have_content('Edit Article')
      end
      it 'title編集フォームが表示される' do
        expect(page).to have_field 'article[title]', with: article.title
      end
      it 'content編集フォームが表示される' do
        expect(page).to have_field 'article[content]', with: article.content
      end
      it 'hashtagフォームが表示される' do
        expect(page).to have_field 'article[hashbody]', with: article.hashbody
      end
    end

    context 'フォームの確認' do
      it '編集に成功する' do
        visit edit_article_path(article)
        click_button 'Done'
        expect(page).to have_content 'Article'
        expect(current_path).to eq '/articles/' + article.id.to_s
      end
    end
  end

  describe '投稿一覧画面のテスト' do
    before do
      visit articles_path
    end

    context '表示の確認' do
      it 'Articlesと表示される' do
        expect(page).to have_content 'Articles'
      end
      it '自分と他人の画像のリンク先が正しい' do
        expect(page).to have_link user.profile_image, href: article_path(article.user)
        expect(page).to have_link user2.profile_image, href: user_path(article2.user)
      end
      it '自分と他人のタイトルのリンク先が正しい' do
        expect(page).to have_link article.title, href: article_path(article)
        expect(page).to have_link article2.title, href: article_path(article2)
      end
    end
  end
end
