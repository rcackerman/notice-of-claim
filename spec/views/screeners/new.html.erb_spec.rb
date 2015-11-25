require 'rails_helper'

RSpec.describe "screeners/new", type: :view do
  before(:each) do
    assign(:screener, Screener.new())
  end

  it "renders new screener form" do
    render

    assert_select "form[action=?][method=?]", screeners_path, "post" do
    end
  end
end
