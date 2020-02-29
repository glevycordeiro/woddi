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

User.destroy_all
Box.destroy_all
BoxLesson.destroy_all
Booking.destroy_all

booking_status = ["active", "cancelled", "redeemed"]

puts 'Creating 10 random users...'

10.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    dob: Date.today-25.years,
    email: Faker::Internet.email,
    password: "123456"
  )
  user.save!
end

user_test = User.create(first_name: "Maria", last_name: "Silva", dob: "21/02/1980", email: "lewagon@gmail.com", password: "123456")


