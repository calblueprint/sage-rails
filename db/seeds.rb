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
                director_id: 1,
                role: 1,
                school_id: 1,
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
  puts "Creating announcement..."
  10.times do |n|
    Announcement.create title: "Announcement #{n}",
                        body: body,
                        school_id: nil,
                        user_id: 1,
                        category: 1
    puts "Created general announcement #{n}"
  end

  10.times do |n|
    Announcement.create title: "Announcement #{n}",
                        body: body,
                        school_id: 1,
                        user_id: 1,
                        category: 0
    puts "Created school announcement #{n}"
  end
end

def first_name
  FFaker::Name.first_name
end

def last_name
  FFaker::Name.last_name
end

def body
  "Disrupt whatever blue bottle waistcoat mumblecore, ennui VHS gluten-free. Actually you probably haven't heard of them vegan, vice cornhole fanny pack pug single-origin coffee beard squid 8-bit. Godard slow-carb listicle, cold-pressed cray craft beer chillwave forage mumblecore 90's brunch artisan freegan messenger bag. Thundercats ugh tote bag, vice cliche before they sold out you probably haven't heard of them. Godard brunch tote bag, poutine lomo waistcoat 90's tattooed fap organic paleo pug. Etsy XOXO master cleanse, waistcoat tote bag chartreuse marfa actually knausgaard offal. Gentrify thundercats next level art party small batch. Brooklyn gentrify blog, knausgaard fashion axe hammock selfies irony vegan thundercats green juice raw denim kickstarter wolf. Photo booth pitchfork roof party, pop-up occupy truffaut scenester humblebrag locavore migas listicle wayfarers offal. Poutine +1 quinoa, photo booth shoreditch narwhal PBR&B. PBR&B biodiesel listicle flexitarian, cray occupy seitan church-key. Pug biodiesel +1 ennui. Selfies waistcoat meggings, hoodie kickstarter forage ugh iPhone jean shorts gastropub. Fingerstache brooklyn asymmetrical humblebrag."
end

create_admins
create_unverified_students
create_verified_students
create_schools
create_announcements

