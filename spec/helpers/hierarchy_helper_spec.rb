require "spec_helper"

describe HierarchyHelper do
  let(:user) { create(:user) }
  let(:children_niche) { create(:niche, user: user) }
  let!(:niche) { create(:niche, user: user) }

  describe "#hierarchy_output" do
    it "returns the valid html" do
      text = hierarchy_output(Niche.all.reject(&:parent))
      expect(text).to have_content(niche.name)
    end

    it "returns the valid html with children" do
      niche.add(children_niche)
      text = hierarchy_output(Niche.all.reject(&:parent))
      expect(text).to have_content(niche.name)
      expect(text).to have_content(children_niche.name)
    end
  end

  describe "#breadcrumb_output" do
    it "returns the valid html with children" do
      niche.add(children_niche)
      text = breadcrumb_output(children_niche)
      expect(text).to have_content(niche.name)
      expect(text).to have_content(children_niche.name)
    end
  end
end
