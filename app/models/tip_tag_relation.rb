class TipTagRelation < ApplicationRecord
  belongs_to :tip
  belongs_to :tag

  validates :tip_id, presence:true
  validates :tag_id, uniqueness: { scope: :tip_id }, presence: true
end
