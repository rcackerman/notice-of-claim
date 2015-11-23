class CreateNotices < ActiveRecord::Migration
  def up
    create_table :notices do |t|
      t.timestamps null: false
      t.string    :name
      t.string    :address
      t.string    :incident_location
      t.datetime :incident_occurred_at
      t.text      :incident_description
      t.boolean   :officer_injured_me
      t.string    :officer_injured_me_how
      t.boolean   :officer_threatened_injury
      t.boolean   :officer_searched
      t.string    :officer_searched_how
      t.boolean   :officer_took_property
      t.text      :officer_took_what
      t.boolean   :officer_damaged_property
      t.text      :officer_damaged_what
      t.boolean   :officer_destroyed_property
      t.text      :officer_destroyed_what
      t.boolean   :officer_arrested_no_probable_cause
      t.boolean   :officer_refused_medical_attention
      t.boolean   :none_of_the_above
      t.integer   :number_officers
      t.boolean   :damages_physical_pain
      t.boolean   :damages_medical_attention
      t.boolean   :damages_miss_work
      t.boolean   :damages_embarrassment
      t.boolean   :damages_property
    end
  end

  def down
    drop_table :notices
  end
end
