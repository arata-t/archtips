require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before do
    @user = FactoryBot.create(:user)
    @tip = FactoryBot.create(:tip)
  end

  describe 'GET /users' do
    # ログイン
    it 'users/sign_inにリクエストすると正常にレスポンスが返ってくる' do
      get new_user_session_path
      expect(response.status).to eq 200
    end
    # 新規登録
    it 'users/sign_upにリクエストすると正常にレスポンスが返ってくる' do
      get new_user_registration_path
      expect(response.status).to eq 200
    end
    # マイページ
    it 'マイページにアクセスすると正常にレスポンスを返す' do
      get user_path(@user.id)
      expect(response.status).to eq 200
    end
    it 'マイページにアクセスするとマイページのニックネームが表示される' do
      get user_path(@user.id)
      expect(response.body).to include @user.nickname
    end
    it 'マイページにアクセスするとマイページの自己紹介が表示される' do
      get user_path(@user.id)
      expect(response.body).to include @user.introduction
    end
    it 'マイページにアクセスすると投稿数が表示される' do
      get user_path(@user.id)
      expect(response.body).to include @user.tips.length.to_s
    end
    it 'マイページにアクセスするといいね数が表示される' do
      get user_path(@user.id)
      expect(response.body).to include @user.likes.length.to_s
    end
    it 'ログインしないでマイページにアクセスすると退会、編集ボタンが表示されない' do
      get user_path(@user.id)
      expect(response.body).not_to include "ユーザー編集"
      expect(response.body).not_to include "　退会する　"
    end
    it 'ログインした状態でマイページにアクセスすると退会、編集ボタンがある' do
      sign_in @user
      get user_path(@user.id)
      expect(response.body).to include "ユーザー編集"
      expect(response.body).to include "　退会する　"
    end
    # ユーザー編集ページ
    it 'ユーザー編集ページにアクセスすると正常に画面が表示される' do
      sign_in @user
      get edit_user_registration_path(@user)
      expect(response.status).to eq 200
    end
    it 'ユーザー編集ページにアクセスすると登録したユーザー情報が表示されている' do
      sign_in @user
      get edit_user_registration_path(@user)
      expect(response.body).to include @user.nickname
      expect(response.body).to include @user.email
      expect(response.body).to include @user.last_name
      expect(response.body).to include @user.first_name
      expect(response.body).to include @user.introduction
    end
  end
end
