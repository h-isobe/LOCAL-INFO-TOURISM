require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) {create(:user)}
  let(:post) {create(:post, user: user)}

  describe "レスポンスステータスのテスト" do

    context "ログイン前はアクセスできないこと" do
      it "新規投稿ページ" do
        get new_post_path
        expect(response.status).to eq 302
        expect(response).to redirect_to new_user_session_path
      end
      it "投稿一覧ページ" do
        get posts_path
        expect(response.status).to eq 302
        expect(response).to redirect_to new_user_session_path
      end
      it "投稿編集ページ" do
        get edit_user_path(post.user)
        expect(response.status).to eq 302
        expect(response).to redirect_to new_user_session_path
      end
      it "ハッシュタグ別の投稿一覧ページ" do
        get hashtag_path(:name)
        expect(response.status).to eq 302
        expect(response).to redirect_to new_user_session_path
      end
      it "カテゴリー別の投稿一覧ページ" do
        get category_path(:name)
        expect(response.status).to eq 302
        expect(response).to redirect_to new_user_session_path
      end
      it "都道府県マップページ" do
        get map_path
        expect(response.status).to eq 302
        expect(response).to redirect_to new_user_session_path
      end
      it "都道府県別の投稿一覧ページ" do
        get prefecture_path
        expect(response.status).to eq 302
        expect(response).to redirect_to new_user_session_path
      end
    end

  end
end
