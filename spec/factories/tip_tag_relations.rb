FactoryBot.define do
  factory :tip_tag_relation do
    association :tag
    association :tip
  end
end
