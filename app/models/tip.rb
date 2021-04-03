class Tip < ApplicationRecord
  validates :title,       presence: true
  validates :category_id, presence: true
  validates :description, presence: true

  belongs_to :user
end

