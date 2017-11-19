class CreateRecommends < ActiveRecord::Migration[5.1]
  def change
    create_table :recommends do |t|
      t.references :user
      t.integer :phase_1
      t.integer :phase_2
      t.integer :phase_3
      t.integer :phase_4
      t.integer :cat_code
      t.boolean :drop
      
      t.timestamps
    end
  end
end
