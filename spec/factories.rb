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

  factory :school do
    name "School"
    lat 0.0
    lng 0.0
    address "Address"
    radius 50
  end

  factory :user do
    email { generate(:email) }
    verified true
    first_name 'First'
    last_name 'Last'
    volunteer_type 0
    password 'password'

    school

    factory :director do
     role 1
    end

    factory :president do
      role 2
    end
  end

  sequence :email do |n|
    "email#{n}@berkeley.edu"
  end
end
