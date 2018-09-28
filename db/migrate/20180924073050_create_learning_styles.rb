class CreateLearningStyles < ActiveRecord::Migration[5.2]
  def change
    create_table :learning_styles do |t|
      t.references :user
      t.jsonb :result
      t.boolean :finished, default: false

      t.timestamps
    end
  end
end
