require 'rails_helper'
describe TipsController, type: :request do
  before do
    @user = FactoryBot.create(:user)
    @user[:id] = @user.id + 1 
    @tip = FactoryBot.create(:tip)
  end

  describe 'Get#index' do
    it 'action#indexにアクセスると正常にレスポンスを返す' do
      get root_path
      expect(response.status).to eq 200
    end
    it 'action#indexにリクエストするとレスポンスに投稿したタイトルが表示されている。' do
      get root_path
      expect(response.body).to include @tip.title
    end
    it 'action#indexにリクエストするとレスポンスに投稿したカテゴリーが表示されている' do
      get root_path
      expect(response.body).to include Category.data[@tip.category_id - 1][:name]
    end
    it 'action#indexにリクエストするとレスポンスに投稿した説明が表示されている。' do
      get root_path
      expect(response.body).to include @tip.description
    end
  end

  describe 'Get#show' do
    it 'action#showにアクセスすると正常にレスポンスを返す' do
      get tip_path(@tip)
      expect(response.status).to eq 200
    end
    it 'action #showにアクセスしたら投稿したタイトルが表示されている' do
      get tip_path(@tip)
      expect(response.body).to include @tip.title
    end
    it 'action #show にアクセスしたら投稿したらカテゴリーが表示されている' do
      get tip_path(@tip)
      expect(response.body).to include Category.data[@tip.category_id - 1][:name]
    end
    it 'action#showにアクセスしたら投稿したら投稿した説明が表示される' do
      get tip_path(@tip)
      expect(response.body).to include @tip.description
    end
  end

  describe 'Get#edit' do
    it 'action#editにリクエストしたら正常にレスポンスを返す' do
      sign_in @user
      get edit_tip_path(@tip)
      expect(response.status).to eq 200
    end
    it 'action#editにアクセスしたら編集前のタイトルが表示されている' do
      sign_in @user
      get edit_tip_path(@tip)
      expect(response.body).to include @tip.title
    end
    it 'action#editにアクセスしたら編集前のカテゴリーが表示されている' do
      sign_in @user
      get edit_tip_path(@tip)
      expect(response.body).to include Category.data[@tip.category_id - 1][:name]
    end
    it 'action#editにアクセスしたら編集前の説明が表示されている' do
      sign_in @user
      get edit_tip_path(@tip)
      expect(response.body).to include @tip.description
    end
    it '許可されていないユーザーがアクセスするとリダイレクトされる' do
      other_user = FactoryBot.create(:user)
      sign_in other_user
      get edit_tip_path(@tip)
      expect(response.status).to eq 302
    end

    it 'サインアウトした状態でアクセスするとリダイレクトされる' do
      get edit_tip_path(@tip)
      expect(response.status).to eq 302
    end
  end
end
