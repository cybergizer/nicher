require 'rails_helper'

RSpec.describe RentItem, type: :model do
  let(:user) { create(:user) }
  let(:contact) { create(:contact) }
  let(:new_contact) { build(:new_contact) }
  let(:item) { create(:item, user: user) }
  subject { create(:rent_item, owner: user, tenant: contact, item: item) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without owner" do
    subject.owner = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without tenant" do
    subject.tenant = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without item" do
    subject.item = nil
    expect(subject).to_not be_valid
  end

  it "shows that tenant can be a user type" do
    subject.tenant = user
    expect(subject).to be_valid
  end

  it "shows that owner can be a contact type" do
    subject.owner = contact
    expect(subject).to be_valid
  end

  it 'is returns actual attributes' do
    subject.tenant = new_contact
    expect(subject.tenant.name).to eq('John')
  end
end
