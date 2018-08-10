require 'rails_helper'

RSpec.describe Niche, type: :model do
  let(:user) { User.create(email: 'test@example.com', password: 'password123', password_confirmation: 'password123') }
  it "is valid with valid attributes" do
    niche = Niche.create(name: 'Home', user_id: user.id)
    expect(niche).to be_valid
  end

  it "is not valid without a name" do
    niche = Niche.create(user_id: user.id)
    expect(niche).to_not be_valid
  end

  it "is not valid without an user" do
    niche = Niche.create(name: 'dwe')
    expect(niche).to_not be_valid
  end

  context "add children to niche" do
    it "create new child" do
      niche = Niche.create(name: 'Home', user_id: user.id)
      niche_children = niche.children.create(name: 'Box1', user_id: user.id)
      expect(niche_children).to be_valid
      expect(niche.children.size).to eq 1
    end

    it "add new child" do
      niche = Niche.create(name: 'Home', user_id: user.id)
      niche_children = Niche.create(name: 'Box1', user_id: user.id)
      niche.add(niche_children)
      expect(niche.children.first).to eq niche_children
      expect(niche.children.size).to eq 1
    end

    it "remove child" do
      niche = Niche.create(name: 'Home', user_id: user.id)
      niche_children = Niche.create(name: 'Box1', user_id: user.id)
      niche.add(niche_children)
      niche.remove(niche_children)
      expect(Niche.find(niche_children.id).parent).to eq nil
      expect(niche.children.size).to eq 0
    end

    it "delete child" do
      niche = Niche.create(name: 'Home', user_id: user.id)
      niche_children = Niche.create(name: 'Box1', user_id: user.id)
      niche.add(niche_children)
      niche.delete(niche_children)
      expect(niche.children.size).to eq 0
    end
  end

  it "when we create model, it creates empty list of items" do
    niche = Niche.create(name: 'Home', user_id: user.id)
    expect(niche.items.size).to eq 0
    expect(niche.items).not_to be_nil
  end

  it "when we create model, it creates empty list of children" do
    niche = Niche.create(name: 'Home', user_id: user.id)
    expect(niche.children.size).to eq 0
    expect(niche.children).not_to be_nil
  end
end
