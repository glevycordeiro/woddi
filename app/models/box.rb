class Box < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  belongs_to :user
  has_many :box_lessons, dependent: :destroy
  has_many :bookings, through: :box_lessons
  has_many :reviews, through: :bookings
  has_many_attached :photos

  def avg_review
    self.reviews.average(:rating)
  end
end
