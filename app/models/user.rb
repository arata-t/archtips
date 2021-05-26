class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, length: { maximum: 6 }
  validates :password, presence: true, format: { with: /[a-z\d]{6,}/i, message: 'は半角英数６文字以上としてください' }
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: 'には全角文字を使用してください' } do
    validates :last_name
    validates :first_name
  end

  has_many :tips
  has_many :comments
  has_many :likes
  has_many :liked_tips, through: :like, source: :tip
  def already_tiped?(tip)
    self.likes.exists?(tip_id: tip.id)
  end
end
