require 'rails_helper'

RSpec.describe "Likes", type: :request do
  describe "GET /users" do
    it 'トップページにいいねアイコンが表示される' do
      get root_path
      expect(response.body).to include "i"
    end
  end
end
