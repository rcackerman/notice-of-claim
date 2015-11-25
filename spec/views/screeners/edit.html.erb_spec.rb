require 'rails_helper'

RSpec.describe "screeners/edit", type: :view do
  before(:each) do
    @screener = assign(:screener, Screener.create!())
  end

  it "renders the edit screener form" do
    render

    assert_select "form[action=?][method=?]", screener_path(@screener), "post" do
    end
  end
end
