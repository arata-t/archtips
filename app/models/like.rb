class Like < ApplicationRecord
  belongs_to :user
  belongs_to :tip

  validates :user_id, presence: true
  validates :tip_id, uniqueness: { scope: :user_id }, presence: true
end
