class AddUserToBoxes < ActiveRecord::Migration[5.2]
  def change
    add_reference :boxes, :user, index: true
  end
end
