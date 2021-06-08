class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # 編集時パスワード入力の省略
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  validates :nickname, presence: true, length: { maximum: 6 }
  validates :password, presence: true, on: :create, format: { with: /[a-z\d]{6,}/i, message: 'は半角英数６文字以上としてください' }
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: 'には全角文字を使用してください' } do
    validates :last_name
    validates :first_name
  end

  has_many :tips, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :likes, :dependent => :destroy
  has_many :liked_tips, through: :likes, source: :tip
  def already_liked?(tip)
    likes.exists?(tip_id: tip.id)
  end
end
