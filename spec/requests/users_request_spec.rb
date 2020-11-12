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

    describe "sign_in" do
      let!(:created_user) { create(:user) }

      it "sign_in a user" do
        post user_session_path
        expect(response.status).to eq(200)
      end
    end
  end
end
