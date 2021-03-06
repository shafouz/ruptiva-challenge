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

      it "saves a new user" do
        post user_registration_path, params: user
        expect(User.count).to eq(1)
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
        expect(User.where(deleted_at: nil).count).to eq(0)
      end
    end

    describe "update user" do

      before(:example) do
        created_user
        login
      end

      it "updates a signed_in user password" do
        params = get_tokens(response).merge({ password: "qwerty123", password_confirmation: "qwerty123" })
        put user_registration_path, params: params 
        expect(response.status).to eq(200)
        delete destroy_user_session_path
        post user_session_path, params: { email: "joao@email.com", password: "qwerty123" }
        expect(response.status).to eq(200)
      end

      it "changes first name" do
        params = get_tokens(response).merge({ password: "qwerty123", password_confirmation: "qwerty123", first_name: "Carlos" })
        put user_registration_path, params: params 
        expect(User.exists?(first_name: "Carlos")).to eq(true)
      end

      it "changes last name" do
        params = get_tokens(response).merge({ password: "qwerty123", password_confirmation: "qwerty123", last_name: "Andre" })
        put user_registration_path, params: params 
        expect(User.exists?(last_name: "Andre")).to eq(true)
      end

      it "changes email" do
        params = get_tokens(response).merge({ password: "qwerty123", password_confirmation: "qwerty123", email: "asdf@asdf.com" })
        put user_registration_path, params: params 
        expect(User.exists?(email: "asdf@asdf.com")).to eq(true)
      end
    end

    describe "getter actions" do
      let!(:user) { create(:user) }

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

  describe "admin actions" do
    let!(:admin) { create(:user, role: "admin") }

    it "fails to get users when not signed in" do
      get users_path
      expect(response.status).to eq(401)
    end

    it "gets all users when signed as admin" do
      login
      get users_path, params: get_tokens(response)
      expect(response.status).to eq(200)
    end

    describe "index using soft delete" do
      before(:each) do
        @user = User.create(first_name: "foo", last_name: "bar", email: "abc@abc.abc", password: "123456789", password_confirmation: "123456789")
        @user.destroy
      end

      it "it doesnt get a soft-deleted user" do
        login
        get users_path, params: get_tokens(response)
        expect(response.body).not_to include("abc@abc.abc")
      end

      it "it still shows all users" do
        login
        get users_path, params: get_tokens(response)
        expect(response.body).to include("joao@email.com")
      end
    end

    it "gets user by email as admin" do
      login
      params = get_tokens(response).merge({ email: "joao@email.com" })
      get admin_user_path, params: params
      expect(response.status).to eq(200)
      expect(response.body).to include("joao@email.com")
    end
  end

end
