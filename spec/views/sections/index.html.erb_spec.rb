require 'rails_helper'

RSpec.describe "sections/index", type: :view do
  before(:each) do
    assign(:sections, [
      Section.create!(
        :name => "Name",
        :description => "MyText"
      ),
      Section.create!(
        :name => "Name",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of sections" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
