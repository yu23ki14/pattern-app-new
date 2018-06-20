class AddColumnToUserMondayRemind < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :monday_remind, :boolean, default: false
  end
end
