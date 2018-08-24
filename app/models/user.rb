class User < ApplicationRecord
  # Userインスタンスのレコードを保存する前に小文字に変換
  before_save { self.email.downcase! }
  
  # 空を許可しない presence: true
  # 長さは50文字 length: { maximum: 50 }
  validates :name, presence: true, length: { maximum: 50 }
  
  # 重複を許さない uniqueness:
  # 大文字と小文字を区別しない case_sensitive: false
  # 正規表現 format: ..
  validates :email, presence: true, length: { maximum: 255 },
                  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                  uniqueness: { case_sensitive: false }
  
  # ログイン認証のための準備(暗号化のために bcrypt Gem が必要)
  has_secure_password
  
  # User と Micropost の多側を表現(手動)
  has_many :microposts
end