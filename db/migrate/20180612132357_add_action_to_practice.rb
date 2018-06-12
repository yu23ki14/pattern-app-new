class AddActionToPractice < ActiveRecord::Migration[5.1]
  def change
    add_column :practices, :action, :text
    add_column :project_practices, :action, :text
  end
end
