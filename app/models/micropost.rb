class Micropost < ApplicationRecord
  # User と Micropost の一側を表現(自動生成)
  belongs_to :user
  
  # バリデーション
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
end