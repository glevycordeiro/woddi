class AddTitleToBoxLessons < ActiveRecord::Migration[5.2]
  def change
    add_column :box_lessons, :title, :string
  end
end
