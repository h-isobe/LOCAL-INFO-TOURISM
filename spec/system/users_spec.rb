require 'rails_helper'

describe "ユーザー認証のテスト" do

  describe "ユーザー新規登録" do
    before do
      visit new_user_registration_path
    end
    context "新規登録画面に遷移" do
      it "新規登録に成功" do
        fill_in "user[name]", with: "佐藤"
        fill_in "user[email]", with: "a@a"
        fill_in "user[password]", with: "111111"
        fill_in "user[password_confirmation]", with: "111111"
        click_on "新規登録"
        expect(page).to have_content "登録"
      end
      it "新規登録に失敗" do
        fill_in "user[name]", with: ""
        fill_in "user[email]", with: ""
        fill_in "user[password]", with: ""
        fill_in "user[password_confirmation]", with: ""
        click_on "新規登録"
        expect(page).to have_content "登録"
      end
    end
  end

  describe "ユーザーログイン" do
    let(:user) {create(:user)}
    before do
      visit new_user_session_path
    end
    context "ログイン画面に遷移" do
      let(:test_user) {user}
      it "ログインに成功" do
        fill_in "user[name]", with: "test_user.name"
        fill_in "user[password]", with: "test_user.password"
        click_button "ログイン"
        expect(page).to have_content "ログイン"
      end
      it "ログインに失敗" do
        fill_in "user[name]", with: ""
        fill_in "user[password]", with: ""
        click_button "ログイン"
        expect(current_path).to eq(new_user_session_path)
      end
    end
  end

end

describe "ユーザーログイン後のテスト" do
  let(:user) {create(:user)} #自分ユーザー
  let!(:user2) {create(:user)} #他人ユーザー
  let!(:post) {create(:post, user: user)}
  before do
    visit new_user_session_path
    fill_in "user[name]", with: user.name
    fill_in "user[password]", with: user.password
    click_button "ログイン"
  end

  describe "マイページ遷移後のテスト" do

    before do
      visit user_path(user)
    end

    describe "サイドバーのテスト" do
      context "表示の確認" do
        it "プロフィール画像が表示される" do
          expect(page).to have_css(".profile_image")
        end
        it "名前が表示される" do
          expect(page).to have_content(user.name)
        end
        it "自己紹介が表示される" do
          expect(page).to have_content(user.introduction)
        end
        it "編集リンクが表示される" do
          expect(page).to have_link "編集", href: edit_user_path(user)
        end
        it "フォローリンクが表示される" do
          expect(page).to have_link "フォロー", href: follower_path(user)
        end
        it "フォロワーリンクが表示される" do
          expect(page).to have_link "フォロワー", href: followed_path(user)
        end
        it "いいね一覧リンクが表示される" do
          expect(page).to have_link "いいね一覧", href: favorite_path(user)
        end
        it "行ってみたい一覧リンクが表示される" do
          expect(page).to have_link "行ってみたい一覧", href: bookmark_path(user)
        end
      end
    end
    
    describe "編集のテスト" do
      context "自分の編集画面への遷移" do
        it "遷移できる" do
          visit edit_user_path(user)
          expect(current_path).to eq("/users/" + user.id.to_s + "/edit")
        end
      end
      context "他人の編集画面への遷移" do
        it "遷移できない" do
          visit edit_user_path(user2)
          expect(current_path).to eq("/users/" + user.id.to_s)
        end
      end
      context "編集画面表示の確認" do
        before do
          visit edit_user_path(user)
        end
        it "名前編集フォームに自分の名前が表示されている" do
          expect(page).to have_field "user[name]", with: user.name
        end
        it "自己紹介フォームに自分の自己紹介が表示されている" do
          expect(page).to have_field "user[introduction]", with: user.introduction
        end
        it "プロフィール画像編集フォームが表示されている" do
          expect(page).to have_field "user[profile_image]", with: user.profile_image
        end
        it "編集に成功する" do
          click_button "編集"
          expect(page).to have_content "編集しました"
          expect(current_path).to eq("/users/" + user.id.to_s)
        end
        it "編集に失敗する" do
          fill_in "user[name]", with: ""
          fill_in "user[introduction]", with: "aaaaaa" 
          click_button "編集"
          expect(page).to have_content "エラーが発生しました"
          expect(current_path).to eq("/users/" + user.id.to_s)
        end
      end
    end

    describe "自分の投稿一覧のテスト" do
      context "表示の確認" do
        it "自分のプロフィール画像が表示される" do
          expect(page).to have_css(".profile_image")
        end
        it "タイトルに詳細リンクが表示される" do
          expect(page).to have_link post.title, href: post_path(post)
        end
        it "ハッシュタグにハッシュタグ投稿のリンクが表示される" do
          post.hashtags.each do |hashtag|
            expect(page).to have_link hashtag.hashname, href: hashtag_path(post,hashname: hashtag.hashname)
          end
        end
      end
    end

    describe "他人の詳細画面のテスト" do
      before do
        visit user_path(user2)
      end
      context "表示の確認" do
        it "編集リンクが表示されない" do
          expect(page).to have_no_link "編集", href: edit_user_path(user2)
        end
        it "行ってみたい一覧が表示されない" do
          expect(page).to have_no_link "行ってみたい一覧", href: bookmark_path(user2)
        end
        it "チャットリンクが表示される" do
          expect(page).to have_css(".chat-room")
        end
      end  
    end
    
  end
end
