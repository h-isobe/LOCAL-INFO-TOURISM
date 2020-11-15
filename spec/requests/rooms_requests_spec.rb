require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  describe "レスポンスステータスのテスト" do
    
    context "ログイン前はアクセスできないこと" do
      it "チャットページ" do
        get "/rooms/:id"
        expect(response.status).to eq 302
        expect(response).to redirect_to new_user_session_path
      end
    end

  end
end
