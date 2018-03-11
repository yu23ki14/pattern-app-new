class AddEventcodeToExchart < ActiveRecord::Migration[5.1]
  def change
    add_reference :excharts, :event, foreign_key: true
  end
end
