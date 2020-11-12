require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "auth paths" do
    let!(:user) { attributes_for(:user) }

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
      let!(:logged_user) { create(:user) }

      it "sign_in a user" do
        post user_session_path, params: user
        expect(response.status).to eq(200)
      end

      it "fails to sign_in inexistent user" do
        post user_session_path, params: { "email": "abc@abc.com", password: "123456789" }
        expect(response.status).to eq(401)
      end

      it "sign_out a user" do
        tokens = logged_user.create_new_auth_token

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
    end
  end
end
