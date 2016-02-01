FactoryGirl.define do
  factory :searched_object do
    trait :multiple_objects do
      vehicle true
      pockets true
      bag true
    end

    trait :other_object do
      other true
      other_details "my dollhouse"
    end
    association :notice, factory: :notice_with_searched_objects
  end
end

