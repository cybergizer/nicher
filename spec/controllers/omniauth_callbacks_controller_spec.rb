require 'rails_helper'

RSpec.describe OmniauthCallbacksController, type: :controller do
  describe "#github" do
    before(:each) do
      request.env['devise.mapping'] = Devise.mappings[:user]
      request.host = 'localhost'
      request.port = '3000'
    end
    it "returns http success" do
      mock_auth_hash[:github]
      request.env['omniauth.auth'] = to_recursive_ostruct(OmniAuth.config.mock_auth[:github])
      get :github
      expect(response).to redirect_to(finish_signup_path(subject.current_user.id))
    end
  end

  describe "#facebook" do
    before(:each) do
      request.env['devise.mapping'] = Devise.mappings[:user]
      request.host = 'localhost'
      request.port = '3000'
    end
    it "returns http success" do
      mock_auth_hash[:facebook]
      request.env['omniauth.auth'] = to_recursive_ostruct(OmniAuth.config.mock_auth[:facebook])
      get :facebook
      expect(response).to redirect_to(root_url)
    end
  end

  describe "#vkontakte" do
    before(:each) do
      request.env['devise.mapping'] = Devise.mappings[:user]
      request.host = 'localhost'
      request.port = '3000'
    end
    it "returns http success" do
      mock_auth_hash[:vkontakte]
      request.env['omniauth.auth'] = to_recursive_ostruct(OmniAuth.config.mock_auth[:vkontakte])
      get :vkontakte
      expect(response).to redirect_to(finish_signup_path(subject.current_user.id))
    end
  end

  describe "#yandex" do
    before(:each) do
      request.env['devise.mapping'] = Devise.mappings[:user]
      request.host = 'localhost'
      request.port = '3000'
    end
    it "returns http success" do
      mock_auth_hash[:yandex]
      request.env['omniauth.auth'] = to_recursive_ostruct(OmniAuth.config.mock_auth[:yandex])
      get :yandex
      expect(response).to redirect_to(root_url)
    end
  end

  describe '#google_oauth2' do
    before(:each) do
      request.env['devise.mapping'] = Devise.mappings[:user]
      request.host = 'localhost'
      request.port = '3000'
    end
    it 'returns http success' do
      mock_auth_hash[:google_oauth2]
      request.env['omniauth.auth'] = to_recursive_ostruct(OmniAuth.config.mock_auth[:google_oauth2])
      get :google_oauth2
      expect(response).to redirect_to(root_url)
    end
  end

end
