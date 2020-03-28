
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'open-uri'

file = URI.open('https://res.cloudinary.com/woddi/image/upload/v1581782638/Showtime/woman-beard-transgender-lgbt-mtf-avatar-512_sdrnd1.png')
# filename = File.basename(URI.parse(url).path)

Review.destroy_all
Order.destroy_all
User.destroy_all
Box.destroy_all
BoxLesson.destroy_all
Booking.destroy_all


booking_status = ["Active", "Checked-in", "Cancelled", "Pending"]

puts 'Creating users...'
10.times do
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, dob: Faker::Date.birthday(min_age: 18, max_age: 65), email: Faker::Internet.email, password: "123456")
end
user_goncalo = User.create(first_name: "Gonçalo", last_name: "Cordeiro", dob: "19/04/1993", email: "gc@gmail.com", password: "123456")
# user_2 = User.create(first_name: "Rui", last_name: "Nabais", dob: "13/08/1994", email: "lisboa@gmail.com", password: "123456")
# # user_3 = User.create(first_name: "João", last_name: "Pereira", dob: "10/11/1992", email: "teste@gmail.com", password: "123456")
# # user_4 = User.create(first_name: "Tomás", last_name: "Viegas", dob: "29/004/1965", email: "lewagonlisboa@gmail.com", password: "123456")
# user_test = User.create(first_name: "Maria", last_name: "Silva", dob: "21/02/1980", email: "lewagon@gmail.com", password: "123456")

#puts "Uploading avatar photos..."
# <img class="avatar-large" alt="avatar-large" src="https://kitt.lewagon.com/placeholder/users/arthur-littm" />
# <img class="avatar-bordered" alt="avatar-bordered" src="https://kitt.lewagon.com/placeholder/users/sarahlafer" />
# <img class="avatar-square" alt="avatar-square" src="https://kitt.lewagon.com/placeholder/users/krokrob" />


# avatar_1 = URI.open('https://res.cloudinary.com/woddi/image/upload/v1583590074/WODDI/man-avatar-profile-vector-21372076_ij54br.jpg')
# user_1.avatar.attach(io: avatar_1, filename: 'man-avatar-profile-vector-21372076_ij54br.jpg', content_type: 'image/jpg')

# avatar_2 = URI.open('https://res.cloudinary.com/woddi/image/upload/v1583590195/WODDI/87-512_o2ubq8.png')
# user_2.avatar.attach(io: avatar_2, filename: '87-512_o2ubq8.png', content_type: 'image/png')

# avatar_3 = URI.open('https://res.cloudinary.com/woddi/image/upload/v1583590241/WODDI/computer-icons-user-profile-avatar-png-favpng-ypy9BWih5X28x0zDEBeemwyx8_ugnogs.jpg')
# User.all.sample.avatar.attach(io: avatar_3, filename: 'computer-icons-user-profile-avatar-png-favpng-ypy9BWih5X28x0zDEBeemwyx8_ugnogs.jpg', content_type: 'image/jpg')

# avatar_4 = URI.open('https://res.cloudinary.com/woddi/image/upload/v1583590312/WODDI/flat-business-man-user-profile-avatar-icon-vector-4333097_bvfbbe.jpg')
# User.all.sample.attach(io: avatar_4, filename: 'flat-business-man-user-profile-avatar-icon-vector-4333097_bvfbbe.jpg', content_type: 'image/jpg')

# avatar_5 = URI.open('https://res.cloudinary.com/woddi/image/upload/v1583590374/WODDI/user-profile-computer-icons-girl-customer-avatar_kpmyne.jpg')
# User.all.sample.attach(io: avatar_5, filename: 'user-profile-computer-icons-girl-customer-avatar_kpmyne.jpg', content_type: 'image/jpg')

puts 'Creating boxes...'

filepath = "#{Rails.root}/db/boxes.json"
serialized_boxes = File.read(filepath)

url = "https://www.crossfit.com/cf/find-a-box.php?page=1&country=PT&state=&city=&type=Commercial"
response = open(url).read
data = JSON.parse(response)

random_photos = ['https://res.cloudinary.com/woddi/image/upload/v1583576510/WODDI/images_b7993t.jpg',
                 'https://res.cloudinary.com/woddi/image/upload/v1583576497/WODDI/crossfit_seeyt1.jpg',
                 'https://res.cloudinary.com/woddi/image/upload/v1583576026/WODDI/crossfit_jxsgji.jpg',
                 'https://res.cloudinary.com/woddi/image/upload/v1583575986/WODDI/big_1_20190619150826_kbibl0.jpg',
                 'https://res.cloudinary.com/woddi/image/upload/v1583443616/WODDI/siglas-do-crossfit1_agsvkn.jpg',
                 'https://res.cloudinary.com/woddi/image/upload/v1583443606/WODDI/22_whzzuz.jpg',
                 'https://res.cloudinary.com/woddi/image/upload/v1583443578/WODDI/thumbs.web.sapo.io_lhbz57.jpg']

data["affiliates"][0..20].each do |affiliate|
  pp affiliate
  box = Box.new(
    address: affiliate["address"] + ", " + affiliate["city"],
    name: affiliate["name"],
    box_url: affiliate["website"],
    user: User.all.sample
    )

  unless affiliate["latlon"].nil?
    box.latitude = affiliate["latlon"].split(",").first
    box.longitude = affiliate["latlon"].split(",").last
  end
  box.save

  photo_1 = URI.open(affiliate["photo"])
  box.photos.attach(io: photo_1, filename: "image_box_#{affiliate['name']}.jpg", content_type: 'image/jpg')
  photo_2 = URI.open(random_photos.sample)
  box.photos.attach(io: photo_2, filename: "image_box_#{affiliate['name']}2.jpg", content_type: 'image/jpg')

  # {"status"=>"0",
  #  "photo"=>"https://profilepicsbucket.crossfit.com/pukie.png",
  #  "ready_to_link"=>"1",
  #  "ordernum"=>"21276",
  #  "latlon"=>"38.51774895659992,-8.90617615008486",
  #  "city"=>"Setúbal",
  #  "name_search"=>"crossfit",
  #  "photo_version"=>"0",
  #  "zip"=>"2900-579",
  #  "country_short_code"=>"PT",
  #  "bad_standing"=>"0",
  #  "effective_date"=>"2019-10-23T07:00:00Z",
  #  "website"=>"https://www.crossfitcais.pt/",
  #  "address"=>"Estrada da Rasca nº 22",
  #  "active"=>"1",
  #  "show_on_map"=>"1",
  #  "kids"=>"0",
  #  "name"=>"CrossFit Cais",
  #  "country"=>"Portugal",
  #  "org_type"=>"Commercial",
  #  "aid"=>"24737"}
end

matchbox = Box.new(
  address: "Rua Dom Luís de Noronha 25, Lisboa",
  name: "Matchbox CrossFit",
  box_url: "http:\/\/www.matchboxcrossfit.com\/",
  user: user_goncalo
  )
matchbox.save

photo_matchbox = URI.open("https://diretoriodefitness.weebly.com/uploads/1/2/6/5/126590655/captura-de-ecr-2019-07-27-s-20-11-21_orig.png")
matchbox.photos.attach(io: photo_matchbox, filename: "Matchbox-Crossfit-Logo", content_type: 'image/png')

puts "Creating classes for each box..."

Box.all.each do |box|

  date = Date.today #Time.new(2020,3,28,5,0,0)
  count = 0
  10.times do
    8.times do
      date += 2.hour
      p date
      box_lesson = BoxLesson.new(
        start_date_time: date,
        end_date_time: date + 1.hour,
        box_id: box.id,
        capacity: rand(10..30),
        status: "",
        price_cents: Faker::Number.between(from: 10, to: 15)*100,
        title: ["WOD", "Gymnastics", "Weightlifting", "Open Box"].sample
      )
      #p box_lesson
      box_lesson.save!
    end
    count += 1
    date = date + count.day
  end
end

puts "Creating bookings..."


puts "Creating reviews..."
matchbox_booking = Booking.create(user: user_goncalo, status: "Checked-in", box_lesson: matchbox.box_lessons.where('start_date_time < ?', Date.today).sample , student_first_name: "Gonçalo", student_email: "gc@gmail.com", student_phone: Faker::PhoneNumber.phone_number_with_country_code, student_last_name: "Cordeiro")

# past = Dete.new(2020, 03, 15)
# today = Date.today
# past.upto(today) do |date|
#   user = User.all.sample
#   booking = Booking.create(user: user, status: ["Active", "Pending", "Checked-in", "Cancelled"].sample, box_lesson: BoxLesson.all.sample, student_first_name: Faker::Name.first_name, student_email: Faker::Internet.email, student_phone: Faker::PhoneNumber.phone_number_with_country_code, student_last_name: Faker::Name.last_name)
#   if booking.status == "Checked-in"
#     Review.create(created_at: date, description: Faker::TvShows::FamilyGuy.quote, rating: rand(1..5), booking: booking)
#   end
# end

BoxLesson.all.each do |bl|
  user = User.all.sample
  booking = Booking.create(user: user, status: ["Active", "Pending", "Checked-in", "Cancelled"].sample, box_lesson: bl, student_first_name: Faker::Name.first_name, student_email: Faker::Internet.email, student_phone: Faker::PhoneNumber.phone_number_with_country_code, student_last_name: Faker::Name.last_name)
  if booking.status == "Checked-in"
    Review.create(description: Faker::TvShows::FamilyGuy.quote, rating: rand(1..5), booking: booking, created_at: (DateTime.now - rand(1..31).days))
  end
end

# review_2 = Review.create(description: "Great Stuff 2" , rating: rand(1..5), booking: Booking.all.sample)

