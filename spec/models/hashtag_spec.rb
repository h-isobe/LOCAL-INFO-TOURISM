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

  describe "アソシエーションのテスト" do
    context "Postモデルとの関係" do
      it "1:Nとなっている" do
        expect(Hashtag.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
    context "PostHashtagモデルとの関係" do
      it "1:Nとなっている" do
        expect(Hashtag.reflect_on_association(:post_hashtags).macro).to eq :has_many
      end
    end
  end
end
