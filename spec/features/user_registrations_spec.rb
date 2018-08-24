require 'rails_helper';

describe 'User registration' do
  let(:first_name) { 'test' }
  let(:user_email) { 'test@gmail.com'  }
  let(:user_password) { 'password'  }

  before :each do
    visit new_user_registration_path

    fill_in 'user_email', with: user_email
    fill_in 'user_password', with: user_password
    fill_in 'user_password_confirmation', with: user_password

    click_button 'Sign up'
  end

  it "redirects to welcome_page" do
    expect(page).to have_selector("section.main_page_content")
  end
end
