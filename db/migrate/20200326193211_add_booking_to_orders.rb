class AddBookingToOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :booking, foreign_key: true
  end
end
