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

  describe "アソシエーションのテスト" do
    context "userモデルとの関係" do
      it "N:1となっている" do
        expect(PostComment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context "Postモデルとの関係" do
      it "N:1となっている" do
        expect(PostComment.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
    context "Notificationモデルとの関係" do
      it "1:Nとなっている" do
        expect(PostComment.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
end

