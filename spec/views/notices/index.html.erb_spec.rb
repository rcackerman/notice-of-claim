require 'rails_helper'

RSpec.describe "notices/index", type: :view do
  before(:each) do
    assign(:notices, [
      Notice.create!(),
      Notice.create!()
    ])
  end

  it "renders a list of notices" do
    render
  end
end
