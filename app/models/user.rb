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
  # User が Relationship(中間テーブル) と一対多である関係
  has_many :relationships
  # 中間テーブルから先のモデルを参照してくれるので、 User から直接、多対多の User 達を取得
  has_many :followings, through: :relationships, source: :follow
  # Railsの命名規則に沿っていない逆方向では必要なオプション
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  # フォロー
  def follow(other_user)
    # 自分自身ではないか
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  # アンフォロー
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  # 既にフォローしているか？
  def following?(other_user)
    self.followings.include?(other_user)
  end
end