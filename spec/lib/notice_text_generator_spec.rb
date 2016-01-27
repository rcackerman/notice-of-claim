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

  describe "#generate_officers" do
    let (:notice_without_officers) { FactoryGirl.create(:notice) }
    let (:notice_with_unnamed_officers) { FactoryGirl.create(:notice_with_officers, number_officers:1, officers_count: 0) }
    let (:notice_with_named_and_unnamed_officers) { FactoryGirl.create(:notice_with_officers, officers_count: 1) }
    let (:notice_with_named_officers) { FactoryGirl.create(:notice_with_officers) }

    context "no number of officers selected" do
      it "should show that all officers are unknown" do
        lg = NoticeTextCreator.new notice_without_officers
        officer_text = lg.generate_officers names_only='t'
        expect(officer_text).to eq("unknown officer(s)")
      end
    end

    context "number of officers selected" do
      context "officers have data entered" do
        it "should use real names" do
          lg = NoticeTextCreator.new notice_with_named_officers
          officer_text = lg.generate_officers names_only='t'
          expect(officer_text).to match(/Bob [0-9]+ and Bob [0-9]+/)
        end
      end

      context "officers have no data entered" do
        it "should use placeholders for names" do
          lg = NoticeTextCreator.new notice_with_unnamed_officers
          officer_text = lg.generate_officers names_only=true
          expect(officer_text).to eq("John Doe")
        end

        it "should use placeholders for all un-entered officers" do
          lg = NoticeTextCreator.new FactoryGirl.create(:notice, number_officers: 2)
          officer_text = lg.generate_officers names_only=true
          expect(officer_text).to eq("John Doe and John Doe")
        end

        context "some officers have data entered" do
          it "should use real names and placeholder names" do
            lg = NoticeTextCreator.new notice_with_named_and_unnamed_officers
            officer_text = lg.generate_officers names_only='t'
            expect(officer_text).to match(/Bob [0-9]+ and John Doe/)
          end
        end
      end

      context "names_only is false" do
        it "should have the word officer" do
          lg = NoticeTextCreator.new notice_with_named_officers
          officer_text = lg.generate_officers names_only=false
          expect(officer_text).to start_with("officer")
        end
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

        context "and there are injury details" do
          let(:details) { FactoryGirl.create(:physical_injury, :multiple_injuries) }

          it "should generate injury details" do
            lg = NoticeTextCreator.new details.notice
            injury_detail_text = lg.generate_incident_details
            expect(injury_detail_text).to match(/by being choked.+tasered.+hit by police vehicle/)
          end

          context "one injury detail is 'other'" do
            pending "should print out text entered"
            pending "should not print out the boolean"
          end
        end

        context "and there are no injury details" do
          it "should not have a double space" do
            # TODO: this test is actually a lie - if it finds any
            # single space it'll pass.
            details = prep_text_generator(:officer_injured_me).generate_incident_details
            expect(details).to_not match('/  /')
          end
        end

        # TODO: model validation that officer_injured_me must be true if
        # injury details are true
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
