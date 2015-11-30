require 'rails_helper'

RSpec.describe "outputs/new", type: :view do
  before(:each) do
    assign(:output, Output.new())
  end

  it "renders new output form" do
    render

    assert_select "form[action=?][method=?]", outputs_path, "post" do
    end
  end
end
