class BoxLesson < ApplicationRecord
  belongs_to :box
  has_many :bookings, dependent: :destroy
  has_many :orders, dependent: :destroy
  monetize :price_cents
end
