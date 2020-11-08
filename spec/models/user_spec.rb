require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーションのテスト" do
    before do
      @user = FactoryBot.create(:user)
    end
    context "ユーザー情報が有効である場合" do
      it "すべて正しく入力されている" do
        expect(@user).to be_valid
      end  
    end
    context "ユーザー情報が無効である場合" do
      it "nameが入力されていない" do
        @user.name = ""
        expect(@user).to be_invalid
      end
      it "nameが2文字以上かつ20文字以下であること" do
        @user.name = "a" * 1 && "a" * 21
        expect(@user).to be_invalid
      end
      it "introductionが200文字以下であること" do
        @user.introduction = "a" * 201
        expect(@user).to be_invalid
      end
    end
  end
end
