class CreatePracticeComments < ActiveRecord::Migration[5.1]
  def change
    create_table :practice_comments do |t|
      t.references :practice
      t.string :comment
      t.timestamps
    end
  end
end
