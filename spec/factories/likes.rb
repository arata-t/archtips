FactoryBot.define do
  factory :like do
    association :tip
    user { tip.user }
  end
end
