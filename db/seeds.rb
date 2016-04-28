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
    school = School.create name: "School#{n}",
                  lat: 37.8670800,
                  lng: -122.2556760,
                  address: address
    puts "Created school #{n}"

    school.users.create first_name: first_name,
                        last_name: last_name,
                        email: "admin#{n}@berkeley.edu",
                        password: 'password',
                        director_id: school.id,
                        role: 1,
                        volunteer_type: 2,
                        verified: true
    puts "Created admin #{n}"

    school.users.create first_name: first_name,
                        last_name: last_name,
                        email: "vstudent#{n}@berkeley.edu",
                        password: 'password',
                        role: 0,
                        volunteer_type: 1,
                        verified: true
    puts "Created verified student #{n}"

    school.users.create first_name: first_name,
                        last_name: last_name,
                        email: "uvstudent#{n}@berkeley.edu",
                        password: 'password',
                        role: 0,
                        volunteer_type: 1,
                        verified: false
    puts "Created student #{n}"

    10.times do |n|
      school.announcements.create title: "Announcement #{n}",
                                  body: body,
                                  user_id: 1,
                                  category: 0
      puts "Created school announcement #{n}"
    end
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
end

def create_semester
  puts "Create uncompleted semester"
  Semester.create start: Time.now - 6.months,
                  season: 1
end

def create_check_ins
  # Creating check ins....
  users = User.verified(true)
  Semester.all.each do |semester|
    users.each do |user|
      10.times do |n|
        CheckIn.create school_id: user.school_id,
                       user_id: user.id,
                       start: Time.now - 6.months + n.weeks,
                       finish: Time.now - 6.months + n.weeks + 1.hour
      end
    end
  end
end

def first_name
  FFaker::Name.first_name
end

def last_name
  FFaker::Name.last_name
end

def address
"#{FFaker::Address.street_address} #{FFaker::AddressUS.city}, #{FFaker::AddressUS.state} #{FFaker::AddressUS.zip_code}"
end

def body
  "Disrupt whatever blue bottle waistcoat mumblecore, ennui VHS gluten-free. Actually you probably haven't heard of them vegan, vice cornhole fanny pack pug single-origin coffee beard squid 8-bit. Godard slow-carb listicle, cold-pressed cray craft beer chillwave forage mumblecore 90's brunch artisan freegan messenger bag. Thundercats ugh tote bag, vice cliche before they sold out you probably haven't heard of them. Godard brunch tote bag, poutine lomo waistcoat 90's tattooed fap organic paleo pug. Etsy XOXO master cleanse, waistcoat tote bag chartreuse marfa actually knausgaard offal. Gentrify thundercats next level art party small batch. Brooklyn gentrify blog, knausgaard fashion axe hammock selfies irony vegan thundercats green juice raw denim kickstarter wolf. Photo booth pitchfork roof party, pop-up occupy truffaut scenester humblebrag locavore migas listicle wayfarers offal. Poutine +1 quinoa, photo booth shoreditch narwhal PBR&B. PBR&B biodiesel listicle flexitarian, cray occupy seitan church-key. Pug biodiesel +1 ennui. Selfies waistcoat meggings, hoodie kickstarter forage ugh iPhone jean shorts gastropub. Fingerstache brooklyn asymmetrical humblebrag."
end

create_schools
create_announcements
create_semester
create_check_ins
