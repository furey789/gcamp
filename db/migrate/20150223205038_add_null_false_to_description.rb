class AddNullFalseToDescription < ActiveRecord::Migration
  def change
    change_column :tasks, :description, :text, null: false
  end
end
