require "spec_helper"

describe ItemsHelper do
  let(:user) { create(:user) }
  let(:niche_old) { create(:niche, user: user) }
  let(:niche_new) { create(:niche, user: user) }
  let(:category_old) { create(:category, user: user) }
  let(:category_new) { create(:category, user: user) }
  let(:item) { create(:item, user: user, niche: niche_old, category: category_old) }

  describe "#search_for_first_niche" do
    it "returns first niche from" do
      item.niche = niche_new
      item.save
      audit = item.audits.first
      expect(search_for_first_niche(audit)).to eq(Niche.find(audit.audited_changes['niche_id'].first))
    end
  end

  describe "#search_for_last_niche" do
    it "returns first niche from" do
      item.niche = niche_new
      item.save
      audit = item.audits.first
      expect(search_for_last_niche(audit)).to eq(Niche.find(audit.audited_changes['niche_id'].last))
    end
  end

  describe "#search_for_first_category" do
    it "returns first niche from" do
      item.category = category_new
      item.save
      audit = item.audits.first
      expect(search_for_first_category(audit)).to eq(Category.find(audit.audited_changes['category_id'].first))
    end
  end

  describe "#search_for_last_category" do
    it "returns first niche from" do
      item.category = category_new
      item.save
      audit = item.audits.first
      expect(search_for_last_category(audit)).to eq(Category.find(audit.audited_changes['category_id'].last))
    end
  end
end
