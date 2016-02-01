FactoryGirl.define do
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
end
