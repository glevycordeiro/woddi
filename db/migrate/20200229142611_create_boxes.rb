class CreateBoxes < ActiveRecord::Migration[5.2]
  def change
    create_table :boxes do |t|
      t.string :address
      t.string :name
      t.string :box_url
      t.string :photos

      t.timestamps
    end
  end
end
