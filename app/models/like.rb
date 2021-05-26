class Like < ApplicationRecord
  belongs_to :user
  belongs_to :tip

  varidates_uniqueness_of :tip_id, scope: :user_id
end
