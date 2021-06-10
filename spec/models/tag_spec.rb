require 'rails_helper'

RSpec.describe Tag, type: :model do
  before do
    @tag = FactoryBot.create(:tag)
  end

  context '正常系' do
    it 'タグが有効である' do
      expect(@tag).to be_valid
    end
    it 'タグが空でも登録できる' do
      @tag.name = nil
      expect(@tag).to be_valid
    end
  end

  context '異常系' do
    it 'タグは同じものは登録できない' do
      @tag.save!
      another_tag = FactoryBot.build(:tag)
      another_tag.name = @tag.name
      another_tag.valid?
      expect(another_tag.errors.full_messages).to include "Name has already been taken"
    end
  end
end
