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
