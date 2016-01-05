FactoryGirl.define do

  factory :semester do
    start 1.year.ago
    finish 1.year.ago + 2.weeks
  end
end
