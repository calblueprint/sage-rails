# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def create_schools
  puts "Creating schools"
  10.times do |n|
    School.create name: "School#{n}",
                  lat: 37.8670800,
                  lng: -122.2556760
    puts "Created school #{n}"
  end
end

def create_admins
  puts "Creating admins..."
  10.times do |n|
    User.create first_name: first_name,
                last_name: last_name,
                email: "admin#{n}@berkeley.edu",
                password: 'password',
                director_id: n,
                role: 1,
                school_id: n,
                volunteer_type: 2,
                verified: true
    puts "Created admin #{n}"
  end
end

def create_verified_students
  puts "Creating verified student..."
  10.times do |n|
    User.create first_name: first_name,
                last_name: last_name,
                email: "vstudent#{n}@berkeley.edu",
                password: 'password',
                role: 0,
                school_id: n,
                volunteer_type: 1,
                verified: true
    puts "Created verified student #{n}"
  end
end

def create_unverified_students
  puts "Creating student..."
  10.times do |n|
    User.create first_name: first_name,
                last_name: last_name,
                email: "uvstudent#{n}@berkeley.edu",
                password: 'password',
                role: 0,
                school_id: n,
                volunteer_type: 1,
                verified: false
    puts "Created student #{n}"
  end
end

def create_announcements
end

def first_name
  FFaker::Name.first_name
end

def last_name
  FFaker::Name.last_name
end

create_admins
create_unverified_students
create_verified_students
create_schools
create_announcements

