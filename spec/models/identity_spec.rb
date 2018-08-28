require 'rails_helper'

RSpec.describe Identity, type: :model do
  let(:identity) { Identity.find_for_oauth(OpenStruct.new({'uid': 'user_uid', 'provider': 'provider_name'})) }

  it "is valid with valid attributes" do
    expect(identity.uid.size).to eq 8
    expect(identity.uid).not_to be_nil
    expect(identity.provider.size).to eq 13
    expect(identity.provider).not_to be_nil
  end
end
