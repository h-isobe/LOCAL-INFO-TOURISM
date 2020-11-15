require 'rails_helper'

describe "レスポンスステータスのテスト" do
  
  context "ログイン前はアクセスできないこと" do
    it "サーチ別の一覧ページ" do
      get "/search"
      expect(response.status).to eq 302
      expect(response).to redirect_to new_user_session_path
    end

  end
end
