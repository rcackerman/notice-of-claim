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
        expect(officers).to eq(["unknown officer(s)"])
      end
    end

    context "number of officers selected" do
      context "officers have data entered" do
        it "should use real names" do
          officer_text = helper.generate_officers(notice_with_named_officers,
                                                  name_only=true)
          expect(officer_text).to contain_exactly(
            a_string_matching(/Bob [0-9]+/),
            a_string_matching(/Bob [0-9]+/))
        end
      end

      context "officers have no data entered" do
        it "should use placeholders for names" do
          officer_text = helper.generate_officers(notice_with_unnamed_officers,
                                                  name_only=true)
          expect(officer_text).to contain_exactly("John Doe")
        end

        it "should use placeholders for all un-entered officers" do
          notice = FactoryGirl.create(:notice, number_officers: 2)
          officer_text = helper.generate_officers(notice,
                                                  name_only=true)
          expect(officer_text).to contain_exactly("John Doe", "John Doe")
        end

        context "some officers have data entered" do
          it "should use real names and placeholder names" do
            officer_text = helper.generate_officers(notice_with_named_and_unnamed_officers,
                                                name_only=true)
            expect(officer_text).to contain_exactly(
              a_string_matching(/Bob [0-9]+/),
              a_string_matching(/John Doe/))
          end
        end
      end
    end

    context "name_only is false" do
      it "should have the word officer" do
        officer_text = helper.generate_officers(notice_with_named_officers)
        expect(officer_text).to contain_exactly(
          a_string_starting_with("officer"),
          a_string_starting_with("officer"))
      end
    end

  end # end #generate_officers

  describe "#generate_injury_details" do

    context "there are injury details" do
      let (:details) { FactoryGirl.create(:physical_injury, :multiple_injuries) }
      let (:other_details) { FactoryGirl.create(:physical_injury, :multiple_injuries, :other_injury) }

      it "should generate injury details" do
        injury_detail_text = helper.generate_injury_details(details)
        expect(injury_detail_text).to match(/by being choked, tasered, and hit by police vehicle/)
      end

      context "one injury detail is 'other'" do
        it "should print out text entered with no boolean" do
          injury_detail_text = helper.generate_injury_details(other_details)
          expect(injury_detail_text).to match(/choked, tasered, hit by police vehicle, and poked/)
        end
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
        so = helper.generate_searched_objects(searched_objects)
        expect(so).to match(/vehicle, bag, and pockets/)
      end

      it "should print out 'other objects' user input without boolean" do
        so = helper.generate_searched_objects(other_searched_objects)
        expect(so).to match(/vehicle, bag, pockets, and my dollhouse/)
      end
    end

    context "there are no objects" do
      pending "- waiting on input"
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

    context "nothing was entered" do
      pending "- wait for input"
    end
  end

  describe "#generate_injury_claims" do
    let (:notice_with_damages) { FactoryGirl.create :notice, :multiple_incidents, :multiple_damage_claims }
    it "should print all claims" do
      injury_claims = helper.generate_injury_claims(notice_with_damages)
      expect(injury_claims).to match(/physical and actual medical expenses/)
    end
  end

  describe "#generate_monetary_claims" do
    let (:notice_with_damages) { FactoryGirl.create :notice, :multiple_incidents, :multiple_damage_claims }
    it "should print all claims" do
      injury_claims = helper.generate_monetary_claims(notice_with_damages)
      expect(injury_claims).to match(
        /medical bills, doctor bills, damages to personal property/)
    end
  end

  describe "#pick_property_claim_type" do
    context "police took objects" do
      let (:notice) { FactoryGirl.create :notice, :taken_object }
      it "should print correct claim type" do
        property_claim = helper.pick_property_claim_type notice
        expect(property_claim).to match(/unlawful seizure and conversion/)
      end
    end
    context "police damaged objects" do
      let (:notice) { FactoryGirl.create :notice, :damaged_object }
      it "should print correct claim type" do
        property_claim = helper.pick_property_claim_type notice
        expect(property_claim).to match(/trespass to chattels/)
      end
    end
    context "police destroyed objects" do
      let (:notice) { FactoryGirl.create :notice, officer_destroyed_property: true }
      it "should print correct claim type" do
        property_claim = helper.pick_property_claim_type notice
        expect(property_claim).to match(/conversion/)
      end
    end
    context "police did multiple things to objects" do
      let (:notice) { FactoryGirl.create :notice, officer_damaged_property: true, officer_destroyed_property: true }
      it "should print all applicable claim types" do
        property_claim = helper.pick_property_claim_type notice
        expect(property_claim).to match(/trespass to chattels.+conversion/)
      end
    end
  end

end
