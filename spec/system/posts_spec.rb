require 'rails_helper'

describe "投稿のテスト" do
  let(:user) {create(:user)}
  let!(:user2) {create(:user)}
  let!(:post) {create(:post, user: user)}
  let!(:post2) {create(:post, user: user2)}
  before do
    visit new_user_session_path
    fill_in "user[name]", with: user.name
    fill_in "user[password]", with: user.password
    click_button "ログイン"
  end

  describe "投稿一覧のテスト" do

    before do
      visit posts_path
    end

    context "サイドバーのテスト 表示の確認" do
      it "カテゴリーのリンクが表示されている" do
        categories = Category.all
        categories.each do |category|
          expect(page).to have_link category.name, href: category_path(post, name: category.name)
        end
      end
      it "ランキングのリンクが表示されている" do
        all_ranks = Post.find(Bookmark.group(:post_id).order(Arel.sql('COUNT(post_id) DESC')).limit(5).pluck(:post_id))
        all_ranks.each.with_index(1) do |rank, i|
          expect(page).to have_link rank.title, href: post_path(rank)
        end
      end
      it "日本地図のリンクが表示されている" do
        expect(page).to have_link "日本地図検索", href: map_path
      end
    end

    context "投稿一覧 自分、他人共通表示の確認" do
      it "投稿者が表示されること" do
        expect(page).to have_content(user.name)
        expect(page).to have_content(user2.name)
      end
      it "タイトルが表示され、リンク遷移先が正しいこと" do
        expect(page).to have_content(post.title)
        expect(page).to have_content(post2.title)
        click_on post.title
        expect(current_path).to eq(post_path(post))
      end
      it "場所が表示されること" do
        expect(page).to have_content(post.prefecture)
        expect(page).to have_content(post2.prefecture)
      end
      it "カテゴリーが表示されること" do
        post.categories.each do |category|
          expect(page).to have_content(post.category)
          expect(page).to have_content(post2.category)
        end
      end
      it "本文が表示されること" do
        expect(page).to have_content(post.body)
        expect(page).to have_content(post2.body)
      end
      it "ハッシュタグが表示され、リンク遷移先が正しいこと" do
        post.hashtags.each do |hashtag|
          expect(page).to have_content(post.hashtag)
          expect(page).to have_content(post2.hashtag)
          expect(page).to have_link hashtag.hashname, href: hashtag_path(post,hashname: hashtag.hashname)
        end
      end
      it "いいね数が表示されること" do
        expect(page).to have_content(post.favorites.count)
        expect(page).to have_content(post2.favorites.count)
      end
      it "行ってみたい数が表示されること" do
        expect(page).to have_content(post.bookmarks.count)
        expect(page).to have_content(post2.bookmarks.count)
      end
      it "コメント数が表示され、リンク先が正しいこと" do
        expect(page).to have_content(post.post_comments.count)
        expect(page).to have_content(post2.post_comments.count)
        expect(page).to have_link post.post_comments.count, href: post_path(post.id)
      end
    end
    
  end

  context "投稿詳細 自分、他人の共通表示の確認" do

    before do
      visit post_path(post)
    end

    it "投稿者の画像が表示されていること" do
      expect(page).to have_content(post.user.profile_image) 
    end
    it "投稿画像が表示されていること" do
      expect(page).to have_css(".post-image") 
    end
    it "投稿のユーザー名が表示されていること" do
      expect(page).to have_content(post.user.name) 
    end
    it "投稿のタイトルが表示されていること" do
      expect(page).to have_content(post.title) 
    end
    it "投稿の本文が表示されていること" do
      expect(page).to have_content(post.body) 
    end
    it "投稿のハッシュタグが表示され、リンク先が正しいこと" do
      post.hashtags.each do |hashtag|
        expect(page).to have_link(hashtag.hashname), href: hashtag_path(post,hashname: hashtag.hashname)
      end
    end
    it "投稿のいいね数が表示されていること" do
      expect(page).to have_content(post.favorites.count)
    end
    it "投稿の行ってみたい数が表示されていること" do
      expect(page).to have_content(post.bookmarks.count)
    end
    it "投稿のコメント数が表示されていること" do
      expect(page).to have_content(post.post_comments.count)
    end
    
  end

  context "投稿詳細 自分の表示の確認" do
    before do
      visit post_path(post)
    end
    it "投稿の閲覧数が表示されていること" do
      expect(page).to have_content(post.impressionist_count)
    end
    it "編集リンクが表示されている" do
      expect(page).to have_link "編集", href: edit_post_path(post)
    end
    it "削除リンクが表示されている" do
      expect(page).to have_link "削除", href: post_path(post)
    end
  end

  context "投稿詳細 他人の表示の確認" do
    before do
      visit post_path(post2)
    end
    it "投稿の閲覧数が表示されないこと" do
      visit post_path(post)
      expect(page).to have_content(post2.impressionist_count)
    end
    it "編集リンクが表示されない" do
      expect(page).to have_no_link "編集", href: edit_post_path(post2)
    end
    it "削除リンクが表示されない" do
      expect(page).to have_no_link "削除", href: post_path(post2)
    end
  end

  describe "投稿フォームのテスト" do

    before do
      visit new_post_path
    end

    context "新規投稿 表示の確認" do
      it "タイトルフォームが表示される" do
        expect(page).to have_field "post[title]"
      end
      it "都道府県選択フォームが表示される" do
        expect(page).to have_field "post[prefecture]"
      end
      it "カテゴリー選択欄が表示される" do
        categories = Category.all
        categories.each do |category|
          expect(page).to have_field('category.name')
        end
      end
      it "投稿内容フォームが表示される" do
        expect(page).to have_field "post[body]"
      end
      it "投稿画像フォームが表示される" do
        expect(page).to have_field "post[post_images_images][]"
      end
      it "送信ボタンが表示される" do
        expect(page).to have_button "送信"
      end
      it "投稿に成功する" do
        fill_in "post[title]", with: Faker::Lorem.characters(number:5)
        fill_in "post[body]", with: Faker::Lorem.characters(number:20)
        click_button "送信"
        expect(page).to have_content "投稿しました"
      end
      it "投稿に失敗する" do
        fill_in "post[title]", with: ""
        fill_in "post[body]", with: Faker::Lorem.characters(number:20)
        click_button "送信"
        expect(page).to have_content "エラーが発生しました"
        expect(current_path).to eq posts_path
      end
      it "投稿に失敗する" do
        fill_in "post[title]", with: Faker::Lorem.characters(number:5)
        fill_in "post[body]", with: ""
        click_button "送信"
        expect(page).to have_content "エラーが発生しました"
        expect(current_path).to eq posts_path
      end 
    end

  end

  describe "編集フォームのテスト" do 

    context "自分の編集画面への遷移" do
      it "遷移できる" do
        visit edit_post_path(post)
        expect(current_path).to eq("/posts/" + post.id.to_s + "/edit") 
      end
    end

    context "他人の編集画面への遷移" do
      it "遷移できない" do
        visit edit_post_path(post2)
        expect(current_path).to eq("/posts")
      end
    end

    context "表示の確認" do
      before do
        visit edit_post_path(post)
      end
      it "タイトルにタイトル名が入力されている" do
        expect(page).to have_field "post[title]", with: post.title
      end
      it "都道府県選択欄が表示されている" do
        expect(page).to have_field "post[prefecture]"
      end
      it "カテゴリー選択欄が表示されている" do
        categories = Category.all
        categories.each do |category|
          expect(page).to have_field('category.name')
        end
      end
      it "投稿内容欄に投稿内容が入力されている" do
        expect(page).to have_field "post[body]", with: post.body
      end
      it "画像選択フォームが表示されている" do
        expect(page).to have_field "post[post_images_images][]"
      end
      it "送信ボタンが表示されている" do
        expect(page).to have_button "送信"
      end
      it "編集が成功する" do
        click_button "送信"
        expect(page).to have_content "編集しました"
        expect(current_path).to eq "/posts/" + post.id.to_s
      end
      it "編集が失敗する" do
        fill_in "post[title]", with: ""
        fill_in "post[body]", with: Faker::Lorem.characters(number:20)
        click_button "送信"
        expect(page).to have_content "エラーが発生しました"
        expect(current_path).to eq "/posts/" + post.id.to_s
      end
      it "編集が失敗する" do
        fill_in "post[title]", with: Faker::Lorem.characters(number:5)
        fill_in "post[body]", with: ""
        click_button "送信"
        expect(page).to have_content "エラーが発生しました"
        expect(current_path).to eq "/posts/" + post.id.to_s
      end
      it "戻るボタンが表示され、リンク先が正しいこと" do
        expect(page).to have_content("戻る")
        expect(page).to have_link "戻る", href: post_path(post)
      end
    end

  end
end
