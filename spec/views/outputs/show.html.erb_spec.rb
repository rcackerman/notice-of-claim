require 'rails_helper'

RSpec.describe "outputs/show", type: :view do
  before(:each) do
    @output = assign(:output, Output.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
