class CreatePhase3s < ActiveRecord::Migration[5.1]
  def change
    create_table :phase3s do |t|
      t.string :choices
      t.string :response
      t.string :nextquestion
      t.references :phase2
      t.integer :context_id
      t.string :phase
      t.timestamps
    end
  end
end
