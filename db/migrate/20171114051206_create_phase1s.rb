class CreatePhase1s < ActiveRecord::Migration[5.1]
  def change
    create_table :phase1s do |t|
      t.string :choices
      t.string :response
      t.string :nextquestion
      
      t.timestamps
    end
  end
end
