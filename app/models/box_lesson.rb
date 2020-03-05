class BoxLesson < ApplicationRecord
  belongs_to :box
  has_many :bookings, dependent: :destroy
end
