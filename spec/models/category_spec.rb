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

  describe "アソシエーションのテスト" do
    context "Postモデルとの関係" do
      it "1:Nとなっている" do
        expect(Category.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
    context "PostCategoryモデルとの関係" do
      it "1:Nとなっている" do
        expect(Category.reflect_on_association(:post_categories).macro).to eq :has_many
      end
    end
  end
end

