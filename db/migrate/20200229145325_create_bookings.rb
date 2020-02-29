class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true
      t.string :status
      t.references :box_lesson, foreign_key: true
      t.string :student_first_name
      t.string :student_last_name
      t.string :student_email
      t.string :student_phone

      t.timestamps
    end
  end
end
