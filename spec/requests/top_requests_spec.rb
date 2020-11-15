require 'rails_helper'

describe "レスポンスステータスのテスト" do
  
  context "ログイン前でもアクセスできること" do
    it "トップページ" do
      get root_path
      expect(response.status).to eq 200
    end
    it "アバウトページ" do
      get home_about_path
      expect(response.status).to eq 200
    end
  end

end
