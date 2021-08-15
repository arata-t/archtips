require 'rails_helper'

RSpec.describe TipTagRelation, type: :model do
  let(:tip_tag_relation){FactoryBot.create(:tip_tag_relation)}

  context '正常系' do
    it 'tip_idとtag_idがあれば正常' do
      expect(tip_tag_relation).to be_valid
    end
    it 'tag_idが同じでもtip_idが異なればあれば正常' do
      tip_tag_relation = FactoryBot.create(:tip_tag_relation)
      expect(FactoryBot.create(:tip_tag_relation, tag_id: tip_tag_relation.tag_id)).to be_valid
    end
    it 'tip_idが同じでもtag_idが異なればあれば正常' do
      tip_tag_relation = FactoryBot.create(:tip_tag_relation)
      expect(FactoryBot.create(:tip_tag_relation, tip_id: tip_tag_relation.tip_id)).to be_valid
    end
  end

  context '異常系' do
    it 'tip_idがなければ無効な状態であること' do
      tip_tag_relation.tip_id = nil
      tip_tag_relation.valid?
      expect(tip_tag_relation.errors.full_messages).to include "Tip must exist"
    end
    it 'tag_idがなければ無効な状態であること' do
      tip_tag_relation.tag_id = nil
      tip_tag_relation.valid?
      expect(tip_tag_relation.errors.full_messages).to include "Tag must exist"
    end
  end
end
