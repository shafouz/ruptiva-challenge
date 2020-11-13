require 'rails_helper'
require './spec/support/test_helper.rb'

RSpec.describe "Users", type: :request do
  include TestHelper

  describe "auth paths" do
    let!(:user) { attributes_for(:user) }
    let(:created_user) { create(:user) }

    describe "new user" do
      it "creates a new user" do 
        post user_registration_path, params: user
        expect(response.status).to eq(200)
      end

      it "fails to create a user" do
        post user_registration_path
        expect(response.status).to eq(422)
      end
    end

    describe "sign_in/sign_out" do
      it "sign_in a user" do
        created_user
        login
        expect(response.status).to eq(200)
      end

      it "fails to sign_in inexistent user" do
        post user_session_path, params: { "email": "abc@abc.com", password: "123456789" }
        expect(response.status).to eq(401)
      end

      it "sign_out a user" do
        tokens = created_user.create_new_auth_token

        delete destroy_user_session_path, params: tokens
        expect(response.status).to eq(200)
      end

      it "fails to sign_out on wrong tokens" do
        tokens = { "uid": "abc@abc.com", "client": "1asdiho", "access-token": "pjdwq123" } 

        delete destroy_user_session_path, params: tokens
        expect(response.status).to eq(404)
      end
    end

    describe "delete user" do
      it "deletes a signed_in user" do
        created_user
        login
        delete user_registration_path, params: get_tokens(response)
        expect(response.status).to eq(200)
      end
    end

    describe "update user" do
      it "updates a signed_in user" do
        created_user
        login
        params = get_tokens(response).merge({ password: "qwerty123", password_confirmation: "qwerty123" })
        put user_registration_path, params: params 
        expect(response.status).to eq(200)
      end
    end
  end

  describe "getter actions" do
    let!(:user) { create(:user) }

    it "fails to get users when not signed in" do
      get users_path
      expect(response.status).to eq(401)
    end

    it "gets all users when signed in" do
      login
      get users_path, params: get_tokens(response)
      expect(response.status).to eq(200)
    end

    it "fails to get user when not signed in" do
      get user_path
      expect(response.status).to eq(401)
    end

    it "gets user when signed in" do
      login
      get user_path, params: get_tokens(response)
      expect(response.status).to eq(200)
    end

  end

end
