class CreateBoxLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :box_lessons do |t|
      t.datetime :start_date_time
      t.datetime :end_date_time
      t.integer :capacity
      t.string :status
      t.references :box, foreign_key: true
      t.integer :price

      t.timestamps
    end
  end
end
