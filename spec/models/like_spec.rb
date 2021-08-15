require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:like){FactoryBot.create(:like)}

  context 'いいねできる' do
    it 'user_idとtip_idがあればいいねができる' do
      expect(like).to be_valid
    end
    it 'tip_idが同じでもuser_idが違えばいいねできる' do
      like = FactoryBot.create(:like)
      expect(FactoryBot.create(:like, tip_id: like.tip_id)).to be_valid
    end
    it 'user_idが同じでもtip_idが違えばいいねできる' do
      like = FactoryBot.create(:like)
      expect(FactoryBot.create(:like, user_id: like.user_id)).to be_valid
    end
  end

  context 'いいねができない' do
    it 'user_idがなければ無効な状態であること' do
      like.user_id = nil
      like.valid?
      expect(like.errors.full_messages).to include "User must exist"
    end
    it 'tip_idがなければ無効な状態であること' do
      like.tip_id = nil
      like.valid?
      expect(like.errors.full_messages).to include "Tip must exist"
    end
  end
end
