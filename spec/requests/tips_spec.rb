require 'rails_helper'
describe TipsController, type: :request do
  before do
    @tip = FactoryBot.create(:tip)
    @user = FactoryBot.create(:user)
  end

  describe 'Get#index' do
    it 'action#indexにアクセスると正常にレスポンスが返ってくる' do
      get root_path
      expect(response.status).to eq 200
    end
    it 'action#indexにリクエストするとレスポンスに投稿したタイトルが表示されている。' do
      get root_path
      expect(response.body).to include @tip.title
    end
    it 'action#indexにリクエストするとレスポンスに投稿したカテゴリーが表示されている' do
      get root_path
      expect(response.body).to include Category.data[@tip.category_id][:name]
    end
    it 'action#indexにリクエストするとレスポンスに投稿した説明が表示されている。' do
      get root_path
      expect(response.body).to include @tip.description
    end
  end
end
