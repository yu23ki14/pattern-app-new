class RenameColumnsToPatterns < ActiveRecord::Migration[5.1]
  def change
    rename_column :patterns, :pattern_name, :pattern_name_ja
    rename_column :patterns, :summary, :summary_ja
    rename_column :patterns, :context, :context_ja
    rename_column :patterns, :b_problem, :b_problem_ja
    rename_column :patterns, :problem, :problem_ja
    rename_column :patterns, :b_solution, :b_solution_ja
    rename_column :patterns, :solution, :solution_ja
    rename_column :patterns, :consequence, :consequence_ja
    
    add_column :patterns, :pattern_name_en, :string
    add_column :patterns, :summary_en, :string
    add_column :patterns, :context_en, :text
    add_column :patterns, :b_problem_en, :string
    add_column :patterns, :problem_en, :text
    add_column :patterns, :b_solution_en, :string
    add_column :patterns, :solution_en, :text
    add_column :patterns, :consequence_en, :text
  end
end
