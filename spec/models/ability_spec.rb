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
    let(:user) { create(:user) }
    it "can manage all" do
      user.add_role 'admin'
      ability = Ability.new(user)
      expect(ability).to be_able_to(:manage, :all)
    end
  end
end
