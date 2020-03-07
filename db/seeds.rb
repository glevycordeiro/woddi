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
# user_1 = User.create(first_name: "Ana", last_name: "Lopes", dob: "01/06/1989", email: "woddi@gmail.com", password: "123456")
# user_2 = User.create(first_name: "Rui", last_name: "Nabais", dob: "13/08/1994", email: "lisboa@gmail.com", password: "123456")
# user_3 = User.create(first_name: "João", last_name: "Pereira", dob: "10/11/1992", email: "teste@gmail.com", password: "123456")
# user_4 = User.create(first_name: "Tomás", last_name: "Viegas", dob: "29/004/1965", email: "lewagonlisboa@gmail.com", password: "123456")
# user_test = User.create(first_name: "Maria", last_name: "Silva", dob: "21/02/1980", email: "lewagon@gmail.com", password: "123456")

puts 'Creating boxes...'

box_1 = Box.create(user: User.all.sample, address: "Rua Aliança Operária, 41C, Lisboa", name: "XXI Crossfit", box_url: "http://www.xxicrossfit.pt/", photos: "data:image/png;base64,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")
box_2 = Box.create(user: User.all.sample, address: "Parque Eduardo VII, 1070-099 Lisboa", name: "Park CrossFit Box", box_url: "https://clubevii.com/park-crossfit-box/park-crossfit/", photos: "https://www.clube-fitness.com/generated_files/siglas-do-crossfit1.jpg")
box_3 = Box.create(user: User.all.sample, address: "Rua Dom Luís de Noronha 25A, 1050-099 Lisboa", name: "MatchBox CrossFit", box_url: "https://www.matchboxcrossfit.com/", photos: "https://nit.pt/wp-content/uploads/2016/10/14caf55c-3d44-408f-a7dd-8acbd85ee6b9-754x394.jpg")
box_4 = Box.create(user: User.all.sample, address: "Rua Dom Luís de Noronha 29, 1050-099 Lisboa", name: "The Bakery Crossfit", box_url: "http://www.thebakerycrossfit.com/", photos: "https://bordalo.observador.pt/500x,q85/https://s3.observador.pt/wp-content/uploads/2015/02/bakery06_770x433_acf_cropped.jpg")
box_5 = Box.create(user: User.all.sample, address: "Rua Dom Luís de Noronha 26, 1050-099 Lisboa", name: "CrossFit Jamor", box_url: "https://www.ironbox.pt/site/default.php", photos: "https://www.ironbox.pt/site/_images/LogoCrossfitJamor.png")
box_6 = Box.create(user: User.all.sample, address: "Rua Dom Luís de Noronha 31, 1050-099 Lisboa", name: "CrossFit LAV", box_url: "https://www.crossfitlav.com/", photos: "https://static.wixstatic.com/media/e8c789_7b0eb501c2dc4bdaba6fc19d9604c7c0~mv2.png/v1/fill/w_558,h_630,al_c,q_85,usm_0.66_1.00_0.01/e8c789_7b0eb501c2dc4bdaba6fc19d9604c7c0~mv2.webp")
box_7 = Box.create(user: User.all.sample, address: "Rua Dom Luís de Noronha 25A, 1050-099 Lisboa", name: "Move On CrossFit", box_url: "http://www.crossfitmoveon.com/", photos: "http://www.crossfitmoveon.com/wp-content/uploads/2018/01/cropped-crossfitt_home.png")
box_8 = Box.create(user: User.all.sample, address: "Rua Professor Fernando da Fonseca, 1600-618 Lisboa", name: "CrossFit Alvalade", box_url: "https://crossfitalvalade.com/", photos: "https://crossfitalvalade.com/wp-content/uploads/2017/10/IMG_7234.jpg")
box_9 = Box.create(user: User.all.sample, address: "Rua Dom Luís de Noronha 25A, 1050-099 Lisboa", name: "CrossFit Odivelas", box_url: "http://crossfitodivelas.pt/", photos: "http://crossfitodivelas.pt/wp-content/uploads/2019/03/CFO-12.jpg")

puts "Creating classes for each box..."

start_date = Faker::Time.between(from: DateTime.now, to: DateTime.now + 14)
Box.all.each do |box|
  100.times do
    box_lesson = BoxLesson.new(
      start_date_time: start_date,
      end_date_time: start_date + (60*60),
      box_id: box.id,
      capacity: rand(1..30),
      status: true,
      price: Faker::Number.between(from: 10, to: 15),
    )
    box_lesson.save!
  end
end

puts "Creating bookings..."
puts "Creating reviews..."

100.times do
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
