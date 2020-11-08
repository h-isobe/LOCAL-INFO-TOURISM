require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "バリデーションのテスト" do
    before do
      @user = FactoryBot.create(:user)
      @post = FactoryBot.create(:post)
    end
    context "投稿が有効である場合" do 
      it "すべて正しく入力されている" do
        expect(@post).to be_valid
      end
    end
    context "投稿が無効である場合" do
      it "titleが入力されていない" do
        @post.title = ""
        expect(@post).to be_invalid
      end
      it "titleが20文字以下であること" do
        @post.title = "a" * 21 
        expect(@post).to be_invalid
      end
      it "bodyが入力されていない" do
        @post.body = ""
        expect(@post).to be_invalid
      end
      it "bodyが500文字以下であること" do
        @post.body = "a" * 501
        expect(@post).to be_invalid
      end
    end  
  end
end
