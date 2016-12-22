class AddCategoryToLesson < ActiveRecord::Migration
  def change
    add_reference :lessons, :category, index: true, foreign_key: true
  end
end
