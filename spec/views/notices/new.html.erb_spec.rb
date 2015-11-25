require 'rails_helper'

RSpec.describe "notices/new", type: :view do
  before(:each) do
    assign(:notice, Notice.new())
  end

  it "renders new notice form" do
    render

    assert_select "form[action=?][method=?]", notices_path, "post" do
    end
  end
end
