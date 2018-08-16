require 'rails_helper'

RSpec.describe Contact, type: :model do
  subject { create(:contact) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end
end
