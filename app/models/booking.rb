class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :box_lesson
end
