require 'rails_helper'
require './lib/notice_letter_creator'

RSpec.describe do

  describe "#new" do
    let (:notice) { FactoryGirl.create(:notice) }

    it "creates a notice letter creator" do
      lg = NoticeTextCreator.new notice
      expect(lg).to be_a(NoticeTextCreator)
    end
  end


    describe "#generate_incident_details" do
      def prep_text_generator incident_type
        notice = FactoryGirl.create(:notice, number_officers: 1, incident_type => true)
        lg = NoticeTextCreator.new notice
        lg
      end

      context "more than one incident type is true" do
        let (:notice) { FactoryGirl.create(:notice_with_multiple_incident_details, number_officers: 1) }

        it "should generate all detail sentences" do
          lg = NoticeTextCreator.new notice
          incident_text = lg.generate_incident_details
          expect(incident_text).to match(/false arrest and false imprisonment/)
          expect(incident_text).to match(/subjected to an assault/)
        end
      end

      context "officer_arrested_no_probable_cause is true" do
        it "should include no probable cause text" do
          details = prep_text_generator(:officer_arrested_no_probable_cause).generate_incident_details
          expect(details).to match(/false imprisonment/)
        end
      end

      context "officer_injured_me is true" do
        it "should include injury text" do
          details = prep_text_generator(:officer_injured_me).generate_incident_details
          expect(details).to match(/suffered a battery/)
        end


      context "officer_threatened_injury" do
        it "should include threatened injury text" do
          details = prep_text_generator(:officer_threatened_injury).generate_incident_details
          expect(details).to match(/subjected to an assault/)
        end
      end

      context "officer_searched" do
        it "should include search text" do
          details = prep_text_generator(:officer_searched).generate_incident_details
          expect(details).to match(/illegal search/)
        end

        pending "it should look up what was searched"
      end

      context "officer_took_property or officer_damaged_property or officer_destroyed_property" do
        it "should include taken property text once" do
          notice = FactoryGirl.create(:notice, officer_took_property: true, officer_damaged_property: true, officer_destroyed_property: true)
          details = NoticeTextCreator.new(notice).generate_incident_details
          expect(details).to match(/Claimant’s property/)
          expect(details).to_not match(/claimant was subjected to.+Claimaint's property/)
        end

        context "and something was seized" do

          it "should say something was seized" do


          end

          it "should not say something was taken" do

          end
        end

        context "and something was taken" do
          it "should say something was taken" do

          end
          it "should not say something was seized" do

          end
        end

        context "and something was both seized and damaged" do
          it "should say so, but only once" do

          end
        end

        context "multiple, overlapping things were taken or destroyed" do
          pending "each item should appear once"
        end
      end

    end

  end
end
