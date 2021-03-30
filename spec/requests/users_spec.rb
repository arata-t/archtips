require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    it "users/sign_inにリクエストすると正常にレスポンスが返ってくる" do
      get new_user_session_path
      expect(response.status).to eq 200
    end
    it "users/sign_upにリクエストすると正常にレスポンスが返ってくる" do
      get new_user_registration_path
      expect(response.status).to eq 200
    end
  end
end
