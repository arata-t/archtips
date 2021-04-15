class Tip < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  validates :title, :description,       presence: true
  validates :category_id, numericality: { other_than: 1 }

  def self.search(search)
    if search != ""
      Tip.where('description LIKE(?)', "%#{search}%")
    else
      Tweet.all
    end
  end
end
