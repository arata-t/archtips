class TipTag

  include ActiveModel::Model
  attr_accessor :title, :category_id, :description, :user_id, :image, :name

  with_options presence: true do
    validates :title
    validates :description
    validates :name
    validates :category_id, numericality: { other_than: 1 }
  end

  def save
    binding.pry
    tip = Tip.create(title: title, category_id: category_id, description: description, image: image, user_id: user_id )
    tag = Tag.where(name: name).first_or_initialize
    tag.save

    TipTagRelation.create(tip_id: tip.id, tag_id: tag.id)
  end
end

