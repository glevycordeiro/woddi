class AddPriceToBoxLessons < ActiveRecord::Migration[5.2]
  def change
    add_monetize :box_lessons, :price, currency: { present: false }
  end
end
