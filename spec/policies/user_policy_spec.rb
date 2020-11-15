require 'rails_helper'
require 'spec_helper'

describe UserPolicy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:admin) { create(:user, role: "admin") }

  permissions :index? do
    it "denies access if not admin" do
      expect(subject).not_to permit(user)
    end

    it "permits if admin" do
      expect(subject).to permit(admin)
    end
  end
end
