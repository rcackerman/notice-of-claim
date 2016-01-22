FactoryGirl.define do
  sequence :officer_name do |n|
    "Bob #{n}"
  end

  factory :officer do
    name { generate(:officer_name) }
    notice
  end

  factory :physical_injury do
    trait :beaten do
      beaten_with_object true
    end
    trait :multiple_injuries do
      choked true
      tasered true
      hit_by_police_vehicle true
    end
    trait :other_injury do
      other true
      other_description "poked"
    end
    association :notice, factory: :notice_with_physical_injury

  end

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
  end
end
