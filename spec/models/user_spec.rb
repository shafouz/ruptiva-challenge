require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    let(:user_attributes) { attributes_for(:user) }

    before(:each) do
      attributes = user_attributes
      attributes[:first_name] = nil
      attributes[:last_name] = nil
      @user = User.new(attributes)
    end

    it "doesnt save without first_name" do
      expect(@user).to_not be_valid
    end

    it "doesnt save without last_name" do
      expect(@user).to_not be_valid
    end
  end

=begin
  describe "soft delete" do
    it "doesnt fully delete a record" do
      User.create(@user)
      User.destroy(1)
      expect(User.count).to eq(1)
    end
  end
=end
end
