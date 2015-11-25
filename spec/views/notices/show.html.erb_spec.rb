require 'rails_helper'

RSpec.describe "notices/show", type: :view do
  before(:each) do
    @notice = assign(:notice, Notice.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
