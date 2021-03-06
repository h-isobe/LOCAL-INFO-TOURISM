require 'rails_helper'

RSpec.describe PostHashtag, type: :model do
  describe "バリデーションのテスト" do
    before do
      @user = FactoryBot.create(:user)
      @post = FactoryBot.create(:post)
      @hashtag = PostHashtag.new(
        post_id: @post.id,
        hashtag_id: @post.id
      )
    end
    context "post_id" do
      it "空でないこと" do
        @hashtag.post_id = ""
        expect(@hashtag).to be_invalid
      end
    end
    context "hashtag_id" do
      it "空でないこと" do
        @hashtag.hashtag_id = ""
        expect(@hashtag).to be_invalid
      end
    end
  end
  
  describe "アソシエーションのテスト" do
    context "Postモデルとの関係" do
      it "N:1となっている" do
        expect(PostHashtag.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
    context "Hashtagモデルとの関係" do
      it "N:1となっている" do
        expect(PostHashtag.reflect_on_association(:hashtag).macro).to eq :belongs_to
      end
    end
  end
end
