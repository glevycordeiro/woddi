class AddCapacityToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :capacity, :integer
  end
end
