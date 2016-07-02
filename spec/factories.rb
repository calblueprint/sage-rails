FactoryGirl.define do
  factory :user_semester do
    user_id 1
    semester_id 1
    completed false
  end

  factory :semester do
    start 1.year.ago
    finish 1.year.ago + 2.weeks
    season 0
  end
end
