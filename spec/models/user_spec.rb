require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it 'is databse authenticable' do
    user = User.create(email: 'test@example.com', password: 'password123', password_confirmation: 'password123')
    expect(user.valid_password?('password123')).to be_truthy
  end
end
