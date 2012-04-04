
FactoryGirl.define do
  factory :video, :class => Refinery::Videos::Video do
    sequence(:file_name) { |n| "refinery#{n}" }
  end
end

