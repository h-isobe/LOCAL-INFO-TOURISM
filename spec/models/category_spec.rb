require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "バリデーションのテスト" do
    before do
      @category = Category.new(
        name: "カテゴリー"
      )
    end
    context "categoryが有効である場合" do
      it "空でないとき" do
        @category
        expect(@category).to be_valid
      end
    end
    context "categoryが無効である場合" do
      it "空であるとき" do  
        @category.name = ""
        expect(@category).to be_invalid
      end
    end
  end
end
