require "spec_helper"

describe HierarchyHelper do
  let(:user) { create(:user) }
  let(:children_niche) { create(:niche, user: user) }
  subject { create(:niche, user: user) }


  describe "#hierarchy_output" do
    it "returns the valid html" do
      niche = subject
      text = hierarchy_output(Niche.all)
      expect(text).to have_content(niche.name)
    end

    it "returns the valid html with children" do
      niche = subject
      niche.add(children_niche)
      text = hierarchy_output(Niche.all.reject(&:parent))
      expect(text).to have_content(niche.name)
      expect(text).to have_content(children_niche.name)
    end
  end
end