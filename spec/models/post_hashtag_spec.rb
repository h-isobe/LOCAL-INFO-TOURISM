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
end
