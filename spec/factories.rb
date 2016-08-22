FactoryGirl.define do
  factory :semester do
    start { generate(:date) }
    finish { generate(:date) }
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

  factory :user_semester do
    completed false
    total_time 0
    status 1

    user
    semester
  end

  sequence :email do |n|
    "email#{n}@berkeley.edu"
  end

  sequence :date do |n|
    DateTime.new(2001, 2, 3) + n.weeks
  end
end
