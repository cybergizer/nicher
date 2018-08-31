require 'rails_helper';

describe 'User registration' do
  let(:user_email) { 'test@gmail.com'  }
  let(:user_password) { 'password'  }
  let(:first_name) { 'first_name' }
  let(:last_name) { 'last_name' }

  before :each do
    visit new_user_registration_path
    fill_in 'user_user_profile_attributes_first_name', with: first_name
    fill_in 'user_user_profile_attributes_last_name', with: last_name
    fill_in 'user_email', with: user_email
    fill_in 'user_password', with: user_password
    fill_in 'user_password_confirmation', with: user_password

    click_button 'Sign up'
  end

  it "redirects to welcome_page" do
    expect(page).to have_selector(".row")
  end
end
