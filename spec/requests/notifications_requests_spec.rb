require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  describe "レスポンスステータスのテスト" do
    
    context "ログイン前はアクセスできないこと" do
      it "通知一覧ページ" do
        get notifications_path
        expect(response.status).to eq 302
        expect(response).to redirect_to new_user_session_path
      end
    end

  end
end
