require 'rails_helper'

RSpec.describe "Screeners", type: :request do
  describe "GET /screeners" do
    it "works! (now write some real specs)" do
      get screeners_path
      expect(response).to have_http_status(200)
    end
  end
end
