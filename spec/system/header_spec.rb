require 'rails_helper'

describe "ヘッダーのテスト" do
  let(:user) {create(:user)}
  before do
    visit root_path
  end

  describe "表示の確認" do

    context "ログイン前" do
      it "Aboutリンクが表示され、リンク先が正しい" do
        expect(page).to have_link "About", href: "/home/about"
        click_link "About"
        visit "/home/about"
      end
      it "新規登録リンクが表示され、リンク先が正しい" do
        expect(page).to have_link "新規登録", href: "/users/sign_up"
        click_link "新規登録"
        visit "/users/sign_up"
      end
      it "ログインリンクが表示され、リンク先が正しい" do
        expect(page).to have_link "ログイン", href: "/users/sign_in"
        click_link "ログイン"
        visit "/users/sign_in"
      end
      it "ゲストログインリンクが表示され、リンク先が正しいこと" do
        expect(page).to have_link "ゲストログイン", href: "/users/guest_sign_in"
        click_link "ゲストログイン"
        expect(current_path).to eq(posts_path)
      end
    end

    context "ログイン後" do
      before do
        visit new_user_session_path
        fill_in "user[name]", with: user.name
        fill_in "user[password]", with: user.password
        click_button "ログイン"
        visit posts_path
      end
      it "マイページリンクが表示され、リンク先が正しいこと" do
        expect(page).to have_link "マイページ", href: user_path(user.id)
        click_link "マイページ"
        visit user_path(user.id)
      end
      it "ログアウトリンクが表示され、リンク先が正しいこと" do
        expect(page).to have_link "ログアウト", href: "/users/sign_out"
        click_link "ログアウト"
        visit "/users/sign_out"
      end
      it "投稿一覧リンクが表示され、リンク先が正しいこと" do
        expect(page).to have_link "投稿一覧", href: "/posts"
        click_link "投稿一覧"
        visit "/posts"
      end
      it "会員一覧リンクが表示され、リンク先が正しいこと" do
        expect(page).to have_link "会員一覧", href: "/users"
        click_link "会員一覧"
        visit "/users"
      end
      it "通知一覧リンクが表示され、リンク先が正しいこと" do
        expect(page).to have_link "通知一覧", href: "/notifications"
        click_link "通知一覧"
        visit "/notifications"
      end
      it "検索機能が表示されていること" do
        expect(page).to have_field "search[content]"
      end
      it "新規投稿リンクアイコンが表示され、リンク先が正しいこと" do
        expect(page).to have_link "", href: "/posts/new"
        click_link ""
        visit "posts/new"
      end
    end
    
  end 
end
