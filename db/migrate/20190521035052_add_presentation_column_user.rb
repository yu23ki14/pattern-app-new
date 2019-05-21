class AddPresentationColumnUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :presentation, :boolean, default: false
  end
end
