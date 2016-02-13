FactoryGirl.define do
  factory :notice do
    name "Jane Doe"
    address "Test Address"
    incident_location "123 Test Street"
    incident_occurred_at Time.now.to_s(:db)

    trait :multiple_incidents do
      officer_arrested_no_probable_cause true
      officer_threatened_injury true
    end

    trait :physical_injury do
      officer_injured_me true
    end
    trait :searched_object do
      officer_searched true
    end
    trait :taken_object do
      officer_took_property true
    end
    trait :damaged_object do
      officer_damaged_property true
    end
    trait :multiple_damage_claims do
      damages_physical_pain true
      damages_medical_attention true
      damages_property true
    end

    factory :notice_with_officers do
      number_officers 2
      # officers_count is declared as a transient attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      transient do
        officers_count 2
      end

      # the after(:create) yields two values; the notice instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the notice is associated properly to the officer
      after(:create) do |notice, evaluator|
        create_list(:officer, evaluator.officers_count, notice: notice)
      end
    end

    factory :notice_with_multiple_incident_details, traits: [:multiple_incidents]
    factory :notice_with_physical_injury, traits: [:physical_injury]
    factory :notice_with_searched_objects, traits: [:searched_object]

    factory :notice_with_lost_object do
      officer_took_property true
      officer_damaged_property true
      
      officer_took_what "my banjo"
      officer_damaged_what "my CD collection"
    end

    factory :notice_with_lost_objects do
      officer_took_property true
      officer_damaged_property true
      officer_destroyed_property true
      
      officer_took_what "my banjo"
      officer_damaged_what "my CD collection"
      officer_destroyed_what "my CD collection"
    end
  end
end
