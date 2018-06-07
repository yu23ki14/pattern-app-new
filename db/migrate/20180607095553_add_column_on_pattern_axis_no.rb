class AddColumnOnPatternAxisNo < ActiveRecord::Migration[5.1]
  def change
    add_column :patterns, :axis_no, :integer
  end
end
