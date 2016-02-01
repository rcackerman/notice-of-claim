require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the NoticesHelper. For example:
#
# describe NoticesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe NoticesHelper, type: :helper do
  describe "#generate_officers" do
    let (:notice_without_officers) { FactoryGirl.create(:notice) }
    let (:notice_with_unnamed_officers) { FactoryGirl.create(:notice_with_officers, number_officers:1, officers_count: 0) }
    let (:notice_with_named_and_unnamed_officers) { FactoryGirl.create(:notice_with_officers, officers_count: 1) }
    let (:notice_with_named_officers) { FactoryGirl.create(:notice_with_officers) }

    context "number of officers selected is 0" do
      it "should show that all officers are unknown" do
        officers = helper.generate_officers(notice_without_officers,
                                            name_only=true)
        expect(officers).to eq("unknown officer(s)")
      end
    end

    context "number of officers selected" do
      context "officers have data entered" do
        it "should use real names" do
          officer_text = helper.generate_officers(notice_with_named_officers,
                                                  name_only=true)
          expect(officer_text).to match(/Bob [0-9]+ and Bob [0-9]+/)
        end
      end

      context "officers have no data entered" do
        it "should use placeholders for names" do
          officer_text = helper.generate_officers(notice_with_unnamed_officers,
                                                  name_only=true)
          expect(officer_text).to eq("John Doe")
        end

        it "should use placeholders for all un-entered officers" do
          notice = FactoryGirl.create(:notice, number_officers: 2)
          officer_text = helper.generate_officers(notice,
                                                  name_only=true)
          expect(officer_text).to eq("John Doe and John Doe")
        end

        context "some officers have data entered" do
          it "should use real names and placeholder names" do
            officer_text = helper.generate_officers(notice_with_named_and_unnamed_officers,
                                                name_only=true)
            expect(officer_text).to match(/Bob [0-9]+ and John Doe/)
          end
        end
      end
    end

    context "name_only is false" do
      it "should have the word officer" do
        officer_text = helper.generate_officers(notice_with_named_officers)
        expect(officer_text).to start_with("officer")
      end
    end

  end # end #generate_officers

  describe "#generate_injury_details" do

    context "there are injury details" do
      let(:details) { FactoryGirl.create(:physical_injury, :multiple_injuries) }

      it "should generate injury details" do
        injury_details = helper.filter_trues(details)
        injury_detail_text = helper.generate_injury_details(injury_details)
        expect(injury_detail_text).to match(/by being choked, tasered, and hit by police vehicle/)
      end

      context "one injury detail is 'other'" do
        pending "should print out text entered"
        pending "should not print out the boolean"
      end
    end

    context "there are no injury details" do
      it "should not have a double space" do
      # TODO: this test is actually a lie - if it finds any
      # single space it'll pass.
      #details = prep_text_generator(:officer_injured_me).generate_incident_details
      #expect(details).to_not match('/  /')
      end
    end

  # TODO: model validation that officer_injured_me must be true if
  # injury details are true
  end # end #generate_injury_details

  describe "#generate_searched_objects" do
    context "there are objects" do
      let (:searched_objects ) { FactoryGirl.create :searched_object, :multiple_objects }
      let (:other_searched_objects) { FactoryGirl.create :searched_object, :multiple_objects, :other_object }

      it "should print out objects" do
        objects = helper.filter_trues(searched_objects)
        so = helper.generate_searched_objects(objects)
        expect(so).to match(/vehicle, bag, and pockets/)
      end

      it "should print out 'other objects' user input" do
        objects = helper.filter_trues(other_searched_objects)
        so = helper.generate_searched_objects(objects)
        expect(so).to match(/vehicle, bag, pockets, and my dollhouse/)
      end
    end

    context "there are no objects" do
      pending "waiting on input"
    end
  end

  describe "#pick_if_seized_damaged" do
    context "something was taken" do
      let (:notice) { FactoryGirl.create :notice, :taken_object } 
      it "should say seized, not damaged" do
        damage = helper.pick_if_seized_damaged notice
        expect(damage).to eq("seized")
        expect(damage).to_not eq("damaged")
      end
    end

    context "something was damaged" do
      let (:notice) { FactoryGirl.create :notice, :damaged_object } 
      it "should say damaged, not seized" do
        damage = helper.pick_if_seized_damaged notice
        expect(damage).to eq("damaged")
        expect(damage).to_not eq("seized")
      end
    end
    
    context "something was seized and damaged" do
      let (:notice) { FactoryGirl.create :notice, :damaged_object, :taken_object } 
      it "should say so, but only once" do
        damage = helper.pick_if_seized_damaged notice
        expect(damage).to match(/seized and damaged/)
      end
    end
  end

  describe "#generate_lost_objects" do
    context "multiple, overlapping things were taken or destroyed" do
      let (:notice) { FactoryGirl.create :notice_with_lost_objects }
      it "should print each item once" do
        lost_objects = helper.generate_lost_objects (notice)
        expect(lost_objects).to eq("my banjo and my CD collection")
      end
    end
  end

end
