require 'rails_helper'

RSpec.describe Location, type: :model do

  it "is valid with valid attributes" do
    user = User.create(email: 'test@example.com', password: 'password123', password_confirmation: 'password123')
    location = Location.create(name: 'dwe', user_id: user.id)
    expect(user).to be_valid
  end

  it "is not valid without a name" do
    user = User.create(email: 'test@example.com', password: 'password123', password_confirmation: 'password123')
    location = Location.create(user_id: user.id)
    expect(location).to_not be_valid
  end

  it "is not valid without an user" do
    location = Location.create(name: 'dwe')
    expect(location).to_not be_valid
  end
end
