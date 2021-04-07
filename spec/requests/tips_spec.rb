require 'rails_helper'

RSpec.describe 'Tips', type: :request do
  before do
    @tip = FactoryBot.create(:tip)
    @user = FactoryBot.create(:user)
  end

  describe 'Get#new' do
    it 'action#newにリクエストするとレスポンスにタイトル入力フォームがかえってくる' do
    end

    it 'action#newにリクエストするとレスポンスにカテゴリー選択フォームがかえってくる' do
    end

    it 'action#newにリクエストするとレスポンスに画像選択フォームがかえってくる' do
    end

    it 'action#newにリクエストするとレスポンスに説明入力フォームがかえってくる' do
    end
  end
end
