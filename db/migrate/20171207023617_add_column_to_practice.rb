class AddColumnToPractice < ActiveRecord::Migration[5.1]
  def change
    add_column :practices, :rate, :integer
  end
end
