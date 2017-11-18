class CreatePhase2s < ActiveRecord::Migration[5.1]
  def change
    create_table :phase2s do |t|
      t.string :choices
      t.string :response
      t.string :nextquestion
      t.references :phase1
      t.string :phase
      
      t.timestamps
    end
  end
end
