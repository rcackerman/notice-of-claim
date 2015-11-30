require 'rails_helper'

RSpec.describe "outputs/index", type: :view do
  before(:each) do
    assign(:outputs, [
      Output.create!(),
      Output.create!()
    ])
  end

  it "renders a list of outputs" do
    render
  end
end
