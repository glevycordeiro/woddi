class Review < ApplicationRecord
  belongs_to :booking

  RATINGS = [1, 2, 3, 4, 5]
  validates :rating, inclusion: { in: RATINGS }

  def user
    self.booking.user
  end
end
