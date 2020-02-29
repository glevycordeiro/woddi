class AddCoordinatesToBoxes < ActiveRecord::Migration[5.2]
  def change
    add_column :boxes, :latitude, :float
    add_column :boxes, :longitude, :float
  end
end
