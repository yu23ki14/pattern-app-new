class AddMondayMailOnProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :monday_remind, :boolean, default: false
  end
end
