require 'rails_helper'

RSpec.describe "screeners/show", type: :view do
  before(:each) do
    @screener = assign(:screener, Screener.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
