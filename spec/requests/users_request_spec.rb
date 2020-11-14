require 'rails_helper'

RSpec.describe "Users", type: :request do 
  let(:user) {create(:user)}

  describe "レスポンスステータスのテスト" do
    
    context "ログイン前はアクセスできないこと" do
      it "会員一覧ページ" do
        get users_path
        expect(response.status).to eq 302
        expect(response).to redirect_to new_user_session_path
      end
      it "マイページ" do
        get user_path(user)
        expect(response.status).to eq 302
        expect(response).to redirect_to new_user_session_path
      end
      it "ユーザー編集ページ" do
        get edit_user_path(user)
        expect(response.status).to eq 302
        expect(response).to redirect_to new_user_session_path
      end
      it "いいね一覧" do
        get favorite_path(user)
        expect(response.status).to eq 302
        expect(response).to redirect_to new_user_session_path
      end
      it "行ってみたい一覧" do
        get bookmark_path(user)
        expect(response.status).to eq 302
        expect(response).to redirect_to new_user_session_path
      end
      it "フォロー" do
        get follower_path(user)
        expect(response.status).to eq 302
        expect(response).to redirect_to new_user_session_path
      end
      it "フォロワー" do
        get followed_path(user)
        expect(response.status).to eq 302
        expect(response).to redirect_to new_user_session_path
      end
    end

  end
end
