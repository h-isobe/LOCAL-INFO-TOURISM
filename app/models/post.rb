class Post < ApplicationRecord
  belongs_to :user
  has_many :post_images, dependent: :destroy
  accepts_attachments_for :post_images, attachment: :image
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  has_many :post_hashtags, dependent: :destroy
  has_many :hashtags, through: :post_hashtags

  validates :title, presence: true
  validates :prefecture, presence: true
  validates :body, length: { in: 1..500 }

  is_impressionable

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  after_create do
    #1.controller側でcreateしたTweetを取得
    post = Post.find_by(id: self.id)
    #2.正規表現を用いて、Postのbody内から『#○○○』の文字列を検出
    hashtags  = self.body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    #3.mapメソッドでtags配列の要素一つ一つを取り出して、先頭の#を取り除いてDBへ保存する
    hashtags.uniq.map do |t|
      hashtag = Hashtag.find_or_create_by(hashname: t.downcase.delete('#'))
      post.hashtags << hashtag
    end
  end

  before_update do
    post = Post.find_by(id: self.id)
    post.hashtags.clear
    #2.正規表現を用いて、Postのbody内から『#○○○』の文字列を検出
    hashtags  = self.body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    #3.mapメソッドでtags配列の要素一つ一つを取り出して、先頭の#を取り除いてDBへ保存する
    hashtags.uniq.map do |t|
      hashtag = Hashtag.find_or_create_by(hashname: t.downcase.delete('#'))
      post.hashtags << hashtag
    end
  end

  enum prefecture: {
    "--未選択--":0,北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
    茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
    新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
    岐阜県:21,静岡県:22,愛知県:23,三重県:24,
    滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
    鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
    徳島県:36,香川県:37,愛媛県:38,高知県:39,
    福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,沖縄県:47
  }
end
