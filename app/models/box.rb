class Box < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  belongs_to :user
  has_many :box_lessons, dependent: :destroy
  has_many :bookings, through: :box_lessons
  has_many :reviews, through: :bookings

  def avg_review
    avg = self.reviews.average(:rating)
    if avg.nil?
      "n/a"
    else
      avg.round
    end
  end
end
