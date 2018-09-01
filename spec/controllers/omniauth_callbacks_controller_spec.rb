require 'rails_helper'

RSpec.describe OmniauthCallbacksController, type: :controller do
  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
    request.host = 'localhost'
    request.port = '3000'
  end

  describe "#github" do
    it "returns http success" do
      request.env['omniauth.auth'] = mock_auth[:'github']
      get :github
      expect(response).to redirect_to(finish_signup_path(subject.current_user.id))
    end
  end

  # describe "#facebook" do
  #  it "returns http success" do
  #    request.env['omniauth.auth'] = mock_auth[:'facebook']
  #    get :facebook
  #    expect(response).to redirect_to(root_url)
  #  end
  #end

  describe "#vkontakte" do
    it "returns http success" do
      request.env['omniauth.auth'] = mock_auth[:'vkontakte']
      get :vkontakte
      expect(response).to redirect_to(finish_signup_path(subject.current_user.id))
    end
  end

  describe "#yandex" do
    it "returns http success" do
      request.env['omniauth.auth'] = mock_auth[:'yandex']
      get :yandex
      expect(response).to redirect_to(root_url)
    end
  end

  # describe '#google_oauth2' do
  #  it 'returns http success' do
  #    request.env['omniauth.auth'] = mock_auth[:'google_oauth2']
  #    get :google_oauth2
  #    expect(response).to redirect_to(root_url)
  #  end
  #end
end
