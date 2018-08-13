require 'rails_helper'

RSpec.describe Niche, type: :model do
  let(:user) { create(:user) }
  subject { create(:niche, user: user) }
  let(:niche) { create(:niche, user: user)  }
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an user" do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end

  context "add children to niche" do
    it "create new child" do
      niche_children = subject.children.create(name: 'Box1', user_id: user.id)
      expect(niche_children).to be_valid
      expect(subject.children.size).to eq 1
    end

    it "add new child" do
      subject.add(niche)
      expect(subject.children.first).to eq niche
      expect(subject.children.size).to eq 1
    end

    it "remove child" do
      subject.add(niche)
      subject.remove(niche)
      expect(Niche.find(niche.id).parent).to eq nil
      expect(subject.children.size).to eq 0
    end
  end
end
