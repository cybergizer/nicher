require 'rails_helper'

RSpec.describe "locations/index", type: :view do
  before(:each) do
    assign(:locations, [
      Location.create!(
        :name => ""
      ),
      Location.create!(
        :name => ""
      )
    ])
  end

  it "renders a list of locations" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
