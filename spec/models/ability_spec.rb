require 'rails_helper'
require "cancan/matchers"

RSpec.describe Ability, type: :model do
  describe "as user" do
    let(:user) { create(:user) }
    it "can read all" do
      ability = Ability.new(user)
      expect(ability).to be_able_to(:read, :all)
    end
  end
  describe "as admin" do
    it "can manage all" do
      user = User.create(email: 'test@example.com', password: 'password123', password_confirmation: 'password123')
      user.add_role 'admin'
      ability = Ability.new(user)
      expect(ability).to be_able_to(:manage, :all)
    end
  end
end
