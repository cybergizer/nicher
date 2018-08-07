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
end
