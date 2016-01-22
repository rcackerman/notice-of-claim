FactoryGirl.define do
  factory :searched_objects do
    trait :multiple_objects do
      vehicle true
      pockets true
      bag true
    end
    trait :other_object do
      other true
      other_details "my dollhouse"
    end
    notice
  end
end

