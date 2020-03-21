
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'open-uri'

#file = open('https://res.cloudinary.com/woddi/image/upload/v1581782638/Showtime/woman-beard-transgender-lgbt-mtf-avatar-512_sdrnd1.png')

# user.image.attach(io: file, filename: 'user-image.jpg')

# url = 'https://res.cloudinary.com/woddi/image/upload/v1581782638/Showtime/woman-beard-transgender-lgbt-mtf-avatar-512_sdrnd1.png'

file = URI.open('https://res.cloudinary.com/woddi/image/upload/v1581782638/Showtime/woman-beard-transgender-lgbt-mtf-avatar-512_sdrnd1.png')
# filename = File.basename(URI.parse(url).path)

Review.destroy_all
User.destroy_all
Box.destroy_all
BoxLesson.destroy_all
Booking.destroy_all


booking_status = ["Active", "Checked-in", "Cancelled", "Pending"]

puts 'Creating users...'

# 10.times do
#   user = User.new(
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     dob: Date.today-25.years,
#     email: Faker::Internet.email,
#     password: "123456"
#   )
#   user.save!
# end

100.times do

  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, dob: Faker::Date.birthday(min_age: 18, max_age: 65), email: Faker::Internet.email, password: "123456")
end
user_1 = User.create(first_name: "Ana", last_name: "Lopes", dob: "01/06/1989", email: "woddi@gmail.com", password: "123456")
user_2 = User.create(first_name: "Rui", last_name: "Nabais", dob: "13/08/1994", email: "lisboa@gmail.com", password: "123456")
# # user_3 = User.create(first_name: "João", last_name: "Pereira", dob: "10/11/1992", email: "teste@gmail.com", password: "123456")
# # user_4 = User.create(first_name: "Tomás", last_name: "Viegas", dob: "29/004/1965", email: "lewagonlisboa@gmail.com", password: "123456")
# user_test = User.create(first_name: "Maria", last_name: "Silva", dob: "21/02/1980", email: "lewagon@gmail.com", password: "123456")

puts "Uploading avatar photos..."


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

require 'byebug'

puts 'Creating boxes...'

filepath = "#{Rails.root}/db/boxes.json"
serialized_boxes = File.read(filepath)

url = "https://www.crossfit.com/cf/find-a-box.php?page=1&country=PT&state=&city=&type=Commercial"
response = open(url).read
data = JSON.parse(response)

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




# boxes = JSON.parse(serialized_boxes)
# # [[40.3604, -74.2894, "CrossFit Persist", "3"],[]]
# boxes.each do |box_info|
#   name = box_info[2]
#   lat = box_info[0]
#   lng = box_info[1]
#   aid = box_info[3]
#   url = "https://map.crossfit.com/getAffiliateInfo.php?aid=#{aid}"

#   response = open(url).read
#   details = JSON.parse(response)

#   Box.near([box_info[0], box_info[1]], 800)
# end




# box_1 = Box.create(user: User.all.sample, address: "Rua Aliança Operária, 41C, Lisboa", name: "XXI Crossfit", box_url: "http://www.xxicrossfit.pt/")
# box_2 = Box.create(user: User.all.sample, address: "Parque Eduardo VII, 1070-099 Lisboa", name: "Park CrossFit Box", box_url: "https://clubevii.com/park-crossfit-box/park-crossfit/" )
# box_3 = Box.create(user: User.all.sample, address: "R. Dom Luís de Noronha 25A, 1050-099 Lisboa", name: "MatchBox CrossFit", box_url: "https://www.matchboxcrossfit.com/")
# box_4 = Box.create(user: User.all.sample, address: "Rua Gomes Freire 6, Lisboa", name: "The Bakery Crossfit", box_url: "http://www.thebakerycrossfit.com/")
# box_5 = Box.create(user: User.all.sample, address: "R. Alexandre Herculano 10, 2795-240 Linda-a-Velha", name: "CrossFit Jamor", box_url: "https://www.ironbox.pt/site/default.php")
# box_6 = Box.create(user: User.all.sample, address: "Av. Duque Loulé Nº50, 2795-118 Linda-a-Velha", name: "CrossFit LAV", box_url: "https://www.crossfitlav.com/")
# box_7 = Box.create(user: User.all.sample, address: "Armazém MIndFit Academy, Rua A, Azinhaga da Torre do Fato, 1600-401 Lisboa", name: "Move On CrossFit", box_url: "http://www.crossfitmoveon.com/")
# box_8 = Box.create(user: User.all.sample, address: "Rua Professor Fernando da Fonseca, 1600-618 Lisboa", name: "CrossFit Alvalade", box_url: "https://crossfitalvalade.com/")
# box_9 = Box.create(user: User.all.sample, address: "Rua Tony de Matos, nº16, 2675-621 Odivelas", name: "CrossFit Odivelas", box_url: "http://crossfitodivelas.pt/", photos: "http://crossfitodivelas.pt/wp-content/uploads/2019/03/CFO-12.jpg")

# puts 'Uploading photos...'

# photo_1 = URI.open('https://res.cloudinary.com/woddi/image/upload/v1583576510/WODDI/images_b7993t.jpg')
# box_1.photos.attach(io: photo_1, filename: 'images_b7993t.jpg', content_type: 'image/jpg')

# photo_2 = URI.open('https://res.cloudinary.com/woddi/image/upload/v1583576497/WODDI/crossfit_seeyt1.jpg')
# box_1.photos.attach(io: photo_2, filename: 'crossfit_seeyt1.jpg', content_type: 'image/jpg')

# photo_3 = URI.open('https://res.cloudinary.com/woddi/image/upload/v1583576026/WODDI/crossfit_jxsgji.jpg')
# box_2.photos.attach(io: photo_3, filename: 'crossfit_jxsgji.jpg', content_type: 'image/jpg')

# photo_4 = URI.open('https://res.cloudinary.com/woddi/image/upload/v1583575986/WODDI/big_1_20190619150826_kbibl0.jpg')
# box_2.photos.attach(io: photo_4, filename: 'big_1_20190619150826_kbibl0.jpg', content_type: 'image/jpg')

# photo_5 = URI.open('https://res.cloudinary.com/woddi/image/upload/v1583443616/WODDI/siglas-do-crossfit1_agsvkn.jpg')
# box_3.photos.attach(io: photo_5, filename: 'siglas-do-crossfit1_agsvkn.jpg', content_type: 'image/jpg')

# photo_6 = URI.open('https://res.cloudinary.com/woddi/image/upload/v1583443606/WODDI/22_whzzuz.jpg')
# box_3.photos.attach(io: photo_6, filename: '22_whzzuz.jpg', content_type: 'image/jpg')

# photo_7 = URI.open('https://res.cloudinary.com/woddi/image/upload/v1583443606/WODDI/22_whzzuz.jpg')
# box_4.photos.attach(io: photo_7, filename: 'ucfpkiyibmhuctojj54z.jpg', content_type: 'image/jpg')

# photo_8 = URI.open('https://res.cloudinary.com/woddi/image/upload/v1583443578/WODDI/thumbs.web.sapo.io_lhbz57.jpg')
# box_4.photos.attach(io: photo_8, filename: 'thumbs.web.sapo.io_lhbz57.jpg', content_type: 'image/jpg')

# photo_9 = URI.open('https://res.cloudinary.com/woddi/image/upload/v1583578731/WODDI/crossfit_c4wyiy.png')
# box_5.photos.attach(io: photo_9, filename: 'crossfit_c4wyiy.png', content_type: 'image/png')

# photo_10 = URI.open('https://res.cloudinary.com/woddi/image/upload/v1583578720/WODDI/slide1_byvgtc.jpg')
# box_5.photos.attach(io: photo_10, filename: 'slide1_byvgtc.jpg', content_type: 'image/jpg')

# photo_11 = URI.open('https://res.cloudinary.com/woddi/image/upload/v1583578720/WODDI/slide1_byvgtc.jpg')
# box_6.photos.attach(io: photo_11, filename: 'images_slq7sc.jpg', content_type: 'image/jpg')

# photo_12 = URI.open('https://res.cloudinary.com/woddi/image/upload/v1583598332/WODDI/crossfit-agachamento_ybn8so.jpg')
# box_7.photos.attach(io: photo_12, filename: 'crossfit-agachamento_ybn8so.jpg', content_type: 'image/jpg')

# photo_13 = URI.open('https://res.cloudinary.com/woddi/image/upload/v1583598407/WODDI/images_tbakld.jpg')
# box_7.photos.attach(io: photo_13, filename: 'images_tbakld.jpg', content_type: 'image/jpg')

puts "Creating classes for each box..."

Box.all.each do |box|
  date = DateTime.new(2020,4,1,5,0,0)
  count = 0
  10.times do
    8.times do
      date += 2.hour
      p date
      box_lesson = BoxLesson.new(
        start_date_time: date,
        end_date_time: date + 1.hour,
        box_id: box.id,
        capacity: rand(1..30),
        status: true,
        price_cents: Faker::Number.between(from: 10, to: 15),
        title: ["WOD", "Gymnastics", "Weightlifting", "Open Box"].sample
      )
    p box_lesson
    box_lesson.save!

  end
  count += 1
  date = DateTime.new(2020,4,1,5,0,0)+count.day
end
end

puts "Creating bookings..."
puts "Creating reviews..."

5.times do############################################500
  user = User.all.sample
  booking = Booking.create(user: user, status: ["Active", "Pending", "Checked-in", "Cancelled"].sample, box_lesson: BoxLesson.all.sample, student_first_name: Faker::Name.first_name, student_email: Faker::Internet.email, student_phone: Faker::PhoneNumber.phone_number_with_country_code, student_last_name: Faker::Name.last_name)
  if booking.status == "Checked-in"
    Review.create(description: Faker::TvShows::FamilyGuy.quote, rating: rand(1..5), booking: booking)
  end
end

# review_2 = Review.create(description: "Great Stuff 2" , rating: rand(1..5), booking: Booking.all.sample)
# review_3 = Review.create(description: "Great Stuff 3" , rating: rand(1..5), booking: Booking.all.sample)
# review_4 = Review.create(description: "Great Stuff 4" , rating: rand(1..5), booking: Booking.all.sample)
# review_5 = Review.create(description: "Great Stuff 5" , rating: rand(1..5), booking: Booking.all.sample)
# review_6 = Review.create(description: "Great Stuff 6" , rating: rand(1..5), booking: Booking.all.sample)
# review_7 = Review.create(description: "Great Stuff 7" , rating: rand(1..5), booking: Booking.all.sample)
# review_8 = Review.create(description: "Great Stuff 8" , rating: rand(1..5), booking: Booking.all.sample)
# review_9 = Review.create(description: "Great Stuff 9" , rating: rand(1..5), booking: Booking.all.sample)
# review_10 = Review.create(description: "Great Stuff 10" , rating: rand(1..5), booking: Booking.all.sample)
# review_11 = Review.create(description: "Bravo 1" , rating: rand(1..5), booking: Booking.all.sample)
# review_12 = Review.create(description: "Bravo 2" , rating: rand(1..5), booking: Booking.all.sample)
# review_13 = Review.create(description: "Bravo 3" , rating: rand(1..5), booking: Booking.all.sample)
# review_14 = Review.create(description: "Bravo 4" , rating: rand(1..5), booking: Booking.all.sample)
# review_15 = Review.create(description: "Bravo 5" , rating: rand(1..5), booking: Booking.all.sample)
# review_16 = Review.create(description: "Bravo 6" , rating: rand(1..5), booking: Booking.all.sample)
# review_17 = Review.create(description: "Bravo 7" , rating: rand(1..5), booking: Booking.all.sample)
# review_18 = Review.create(description: "Bravo 8" , rating: rand(1..5), booking: Booking.all.sample)
# review_19 = Review.create(description: "Bravo 9" , rating: rand(1..5), booking: Booking.all.sample)
# review_20 = Review.create(description: "Bravo 10" , rating: rand(1..5), booking: Booking.all.sample)
# review_21 = Review.create(description: "Bis 1" , rating: rand(1..5), booking: Booking.all.sample)
# review_22 = Review.create(description: "Bis 2" , rating: rand(1..5), booking: Booking.all.sample)
# review_23 = Review.create(description: "Bis 3" , rating: rand(1..5), booking: Booking.all.sample)
# review_24 = Review.create(description: "Bis 4" , rating: rand(1..5), booking: Booking.all.sample)
# review_25 = Review.create(description: "Bis 5" , rating: rand(1..5), booking: Booking.all.sample)
# review_26 = Review.create(description: "Bis 6" , rating: rand(1..5), booking: Booking.all.sample)
# review_27 = Review.create(description: "Bis 7" , rating: rand(1..5), booking: Booking.all.sample)
# review_28 = Review.create(description: "Bis 8" , rating: rand(1..5), booking: Booking.all.sample)
# review_29 = Review.create(description: "Bis 9" , rating: rand(1..5), booking: Booking.all.sample)
# review_30 = Review.create(description: "Bis 10" , rating: rand(1..5), booking: Booking.all.sample)
