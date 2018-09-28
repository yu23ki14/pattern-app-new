class AddLearningStyleIdToPatterns < ActiveRecord::Migration[5.2]
  def change
    add_column :patterns, :learning_style_identifier, :integer
  end
end
