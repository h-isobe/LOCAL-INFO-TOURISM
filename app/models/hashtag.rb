class Hashtag < ApplicationRecord
  has_many :post_hashtags, dependent: :destroy
  has_many :posts, through: :post_hashtags
  validates :hashname, presence: true, length: { maximum: 50 }
end
