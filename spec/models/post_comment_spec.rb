require 'rails_helper'

RSpec.describe PostComment, type: :model do
  describe "バリデーションのテスト" do
    before do
      @user = FactoryBot.create(:user)
      @post = FactoryBot.create(:post)
      @comment = PostComment.new(
        user_id: @user.id,
        post_id: @post.id,
        comment: "コメント"
      )
    end
    context "コメントが有効である場合" do
      it "すべて正しく入力されている" do
        expect(@comment).to be_valid
      end
    end
    context "コメントが無効である場合" do
      it "commentが入力されていない" do
        @comment.comment = ""
        expect(@comment).to be_invalid
      end
      it "commentが500文字以下であること" do
        @comment.comment = "a" * 501
        expect(@comment).to be_invalid
      end
    end
  end
end
