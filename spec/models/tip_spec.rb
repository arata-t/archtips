require 'rails_helper'

RSpec.describe Tip, type: :model do
  before do
    @tip = FactoryBot.build(:tip)
  end
end
