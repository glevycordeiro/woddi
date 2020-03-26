class Order < ApplicationRecord
  belongs_to :user
  belongs_to :box_lesson
  belongs_to :booking
  monetize :amount_cents
end
