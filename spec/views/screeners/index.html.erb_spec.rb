require 'rails_helper'

RSpec.describe "screeners/index", type: :view do
  before(:each) do
    assign(:screeners, [
      Screener.create!(),
      Screener.create!()
    ])
  end

  it "renders a list of screeners" do
    render
  end
end
