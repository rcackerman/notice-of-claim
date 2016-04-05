require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#display_time" do
    let (:time) { Time.now.midnight }
    context "at midnight" do
      it "should display 12:00 AM" do
        t = display_time(time)
        expect(t).to eq("12:00 AM")

      end
    end
  end

end
