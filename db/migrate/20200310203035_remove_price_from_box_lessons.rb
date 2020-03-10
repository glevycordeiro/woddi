class RemovePriceFromBoxLessons < ActiveRecord::Migration[5.2]
  def change
    remove_column :box_lessons, :price, :integer
  end
end
