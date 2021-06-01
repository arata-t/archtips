require 'rails_helper'

RSpec.describe "Likes", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @tip = FactoryBot.create(:tip)
  end

  describe "GET /users" do
    it 'トップページにいいねアイコンが表示される' do
      get root_path
      expect(response.body).to include "i"
    end
  end
end
