class CreateProjectPracticeComments < ActiveRecord::Migration[5.1]
  def change
    create_table :project_practice_comments do |t|
      t.references :user
      t.references :project_practice
      t.string :comment
      t.timestamps
    end
  end
end
