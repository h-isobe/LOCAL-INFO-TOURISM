require 'rails_helper'

RSpec.describe Hashtag, type: :model do
  describe "バリデーションのテスト" do
    before do
      @hashtag = Hashtag.new(
        hashname: "ハッシュタグ"
      )
    end
    context "hashnameが有効である場合" do
      it "空でないとき" do
        @hashtag
        expect(@hashtag).to be_valid
      end
    end
    context "hashnameが無効である場合" do
      it "空であるとき" do
        @hashtag.hashname = ""
        expect(@hashtag).to be_invalid
      end
    end
  end
end
