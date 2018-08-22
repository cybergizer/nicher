require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is databse authenticable' do
    user = User.create(email: 'test@example.com', password: 'password123', password_confirmation: 'password123')
    expect(user.valid_password?('password123')).to be_truthy
  end

  it "is valid with valid attributes" do
    user = User.create(email: 'test@example.com', password: 'password123', password_confirmation: 'password123')
    expect(user).to be_valid
  end

  it "is not valid without an email" do
    user = User.create(password: 'password123', password_confirmation: 'password123')
    expect(user).to_not be_valid
  end

  it "is not valid without a password" do
    user = User.create(email: 'test@example.com')
    expect(user).to_not be_valid
  end

  it "when we create model, it creates empty list of items" do
    user = User.create(email: 'test@example.com', password: 'password123', password_confirmation: 'password123')
    expect(user.items.size).to eq 0
    expect(user.items).not_to be_nil
  end

  it "when we create model, it creates empty list of niches" do
    user = User.create(email: 'test@example.com', password: 'password123', password_confirmation: 'password123')
    expect(user.niches.size).to eq 0
    expect(user.niches).not_to be_nil
  end

  it "is valid with valid oauth attributes" do
    user = AuthService.new(auth = OpenStruct.new({'uid': 'user_uid', 'provider': 'provider_name', 'info': OpenStruct.new({'email': 'user_email@example.com'}), 'extra': OpenStruct.new({'raw_info': OpenStruct.new({'email': 'user_email@example.com', 'name': 'Shizuku Tsukishima'})})}), signed_in_resource = nil).find_for_oauth
    expect(user).to be_valid
  end

end
