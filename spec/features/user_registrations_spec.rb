require 'rails_helper';

describe 'User registration' do
  let(:first_name) { 'test' }
  let(:user_email) { 'test@gmail.com'  }
  let(:user_password) { 'password'  }

  before :each do
    visit new_user_registration_path

    fill_in 'user_first_name', with: user_email
    fill_in 'user_email', with: user_email
    fill_in 'user_password', with: user_password
    fill_in 'user_password_confirmation', with: user_password

    click_button 'Sign up'
  end

  it "shows message with instructions" do
    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
end
