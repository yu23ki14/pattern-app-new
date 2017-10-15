class CreatePatterns < ActiveRecord::Migration[5.1]
  def change
    create_table :patterns do |t|
      t.string :lg_code
      t.string :cat_code
      t.integer :pattern_no
      t.string :pattern_name
      t.string :summary
      t.text :context
      t.string :b_problem
      t.text :problem
      t.string :b_solution
      t.text :solution
      t.text :consequence

      t.timestamps
    end
  end
end
