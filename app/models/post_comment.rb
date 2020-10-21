class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :notifications, dependent: :destroy
  validates :comment, presence: true
  validates :comment, length: { in: 1..500 }
end