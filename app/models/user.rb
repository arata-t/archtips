class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :nickname, presence: true, length: { maximum: 6 }

         with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: 'には全角文字を使用してください' } do
          validates :last_name
          validates :first_name
         end
end