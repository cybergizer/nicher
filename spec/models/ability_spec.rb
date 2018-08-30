require 'rails_helper'
require "cancan/matchers"

RSpec.describe Ability, type: :model do
  describe "as admin" do
    let(:user) { create(:user) }
    it "has full access" do
      user.add_role('admin')
      ability = Ability.new(user)
      expect(ability).to be_able_to(:access, :rails_admin)
      expect(ability).to be_able_to(:manage, :all)
    end
  end
end
