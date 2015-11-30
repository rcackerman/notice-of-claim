require 'rails_helper'

RSpec.describe "outputs/edit", type: :view do
  before(:each) do
    @output = assign(:output, Output.create!())
  end

  it "renders the edit output form" do
    render

    assert_select "form[action=?][method=?]", output_path(@output), "post" do
    end
  end
end
