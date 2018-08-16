require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  let(:user) { create(:user) }

  describe "After sigin-in" do

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end

    it "redirects to the root_path" do
      user.sign_in_count = 2
      user.save
      post :create, params: { user: { email: user.email, password: user.password } }
      expect(response).to redirect_to(root_path)
    end

    it "redirects to the edit_user_path if new user" do
      post :create, params: { user: { email: user.email, password: user.password } }
      expect(response).to redirect_to(edit_user_path(user.id))
    end
  end
end
