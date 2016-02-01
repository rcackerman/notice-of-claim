FactoryGirl.define do
  sequence :officer_name do |n|
    "Bob #{n}"
  end

  factory :officer do
    name { generate(:officer_name) }
    notice
  end
end
