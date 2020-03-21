class Order < ApplicationRecord
  belongs_to :user
  belongs_to :box_lesson
  monetize :amount_cents
end
