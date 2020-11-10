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
  
  describe "アソシエーションのテスト" do
    context "Userモデルとの関係" do
      it "N:1となっている" do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context "PostImageモデルとの関係" do
      it "1:Nとなっている" do
        expect(Post.reflect_on_association(:post_images).macro).to eq :has_many
      end
    end
    context "Favoriteモデルとの関係" do
      it "1:Nとなっている" do
        expect(Post.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
    context "Bookmarkモデルとの関係" do
      it "1:Nとなっている" do
        expect(Post.reflect_on_association(:bookmarks).macro).to eq :has_many
      end
    end
    context "PostCommentモデルとの関係" do
      it "1:Nとなっている" do
        expect(Post.reflect_on_association(:post_comments).macro).to eq :has_many
      end
    end
    context "PostCategoryモデルとの関係" do
      it "1:Nとなっている" do
        expect(Post.reflect_on_association(:post_categories).macro).to eq :has_many
      end
    end
    context "categoryモデルとの関係" do
      it "1:Nとなっている" do
        expect(Post.reflect_on_association(:categories).macro).to eq :has_many
      end
    end
    context "PostHashtagモデルとの関係" do
      it "1:Nとなっている" do
        expect(Post.reflect_on_association(:post_hashtags).macro).to eq :has_many
      end
    end
    context "Hashtagモデルとの関係" do
      it "1:Nとなっている" do
        expect(Post.reflect_on_association(:hashtags).macro).to eq :has_many
      end
    end
    context "Notificationモデルとの関係" do
      it "1:Nとなっている" do
        expect(Post.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
end
