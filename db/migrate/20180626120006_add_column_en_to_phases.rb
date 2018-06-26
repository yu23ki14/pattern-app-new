class AddColumnEnToPhases < ActiveRecord::Migration[5.1]
  def change
    add_column :phase1s, :choices_en, :string
    add_column :phase1s, :response_en, :string
    add_column :phase1s, :nextquestion_en, :string
    rename_column :phase1s, :choices, :choices_ja
    rename_column :phase1s, :response, :response_ja
    rename_column :phase1s, :nextquestion, :nextquestion_ja
    
    add_column :phase2s, :choices_en, :string
    add_column :phase2s, :response_en, :string
    add_column :phase2s, :nextquestion_en, :string
    rename_column :phase2s, :choices, :choices_ja
    rename_column :phase2s, :response, :response_ja
    rename_column :phase2s, :nextquestion, :nextquestion_ja
    
    add_column :phase3s, :choices_en, :string
    add_column :phase3s, :response_en, :string
    add_column :phase3s, :nextquestion_en, :string
    rename_column :phase3s, :choices, :choices_ja
    rename_column :phase3s, :response, :response_ja
    rename_column :phase3s, :nextquestion, :nextquestion_ja
    
    add_column :phase4s, :choices_en, :string
    add_column :phase4s, :response_en, :string
    add_column :phase4s, :nextquestion_en, :string
    rename_column :phase4s, :choices, :choices_ja
    rename_column :phase4s, :response, :response_ja
    rename_column :phase4s, :nextquestion, :nextquestion_ja
    
  end
end
