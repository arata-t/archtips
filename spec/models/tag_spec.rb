require 'rails_helper'

RSpec.describe Tag, type: :model do
  before do
    @tag = FactoryBot.create(:tag)
  end

  context do
    it 'タグが有効である' do
      expect(@tag).to be_valid
    end
    it 'タグは同じものは登録できない' do
      @tag.save!
      another_tag = FactoryBot.build(:tag)
      another_tag.name = @tag.name
      another_tag.valid?
      expect(another_tag.errors.full_messages).to include "Name has already been taken"
    end
  end
end
