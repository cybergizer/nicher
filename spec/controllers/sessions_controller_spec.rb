require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  login_user
  let(:user) { subject.current_user }

  controller do
    def after_sign_in_path_for(resource)
      super resource
    end
  end

  describe "After sigin-in" do
    it "redirects to the root_path" do
      user.sign_in_count = 2
      expect(controller.after_sign_in_path_for(user)).to eq(root_path)
    end

    it "redirects to the edit_user_path if new user" do
      user.sign_in_count = 1
      expect(controller.after_sign_in_path_for(user)).to eq(edit_user_path(user.id))
    end
  end
end
