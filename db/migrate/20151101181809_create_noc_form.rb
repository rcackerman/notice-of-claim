class CreateNocForm < ActiveRecord::Migration
  def change
    create_table :notice_of_claim_answers do |t|
      t.text :victim_name
      t.boolean :self_report
      t.boolean :child_report
      t.boolean :other_report
      t.text :child_name
      t.text :email
      t.text :address
      t.text :incident_address
      t.date_time :incident_time
      t.boolean :physical_injury
      t.boolean :physical_injury_threat
      t.boolean :search_without_permission
      t.boolean :property_taken
      t.boolean :property_damaged
      t.boolean :arrest_without_probable_cause
      t.boolean :medical_attention_denied
      t.boolean :none_of_the_above
      t.integer :number_of_officers

      t.timestamps null: false
    end

    create_table :physical_injury_details do |t|
      t.boolean :beaten_with_object
      t.boolean :hit_by_police_vehicle
      t.boolean :choked
      t.boolean :pepper_sprayed
      t.boolean :tasered
      t.boolean :attacked_by_police_animal
      t.boolean :physical_force
      t.boolean :handcuffs_applied_tightly
      t.boolean :other
      t.text    :other_description
      t.timestamps null: false
    end

    create_table :physical_injury_details do |t|
      t.boolean :vehicle
      t.boolean :bag
      t.boolean :pockets
      t.boolean :home
      t.boolean :other
      t.text    :other_description
      t.timestamps null: false
    end

    create_table :damages do |t|
      t.boolean :physical_pain
      t.boolean :medical_attention_sought
      t.boolean :miss_work
      t.boolean :embarrassment_or_humiliation
      t.boolean :emotional_distress
      t.boolean :property_lost
    end

    add_foreign_key :notice_of_claim_answers, :physical_injury_details
    add_foreign_key :notice_of_claim_answers, :unlawful_search_details
    add_foreign_key :notice_of_claim_answers, :damages
  end
end
