class CreatePresentationPostPatternRelates < ActiveRecord::Migration[5.2]
  def change
    create_table :presentation_post_pattern_relates do |t|
      t.references :pattern, index: true, foreign_key: true
      t.references :presentation_post, index: true, foreign_key: true
      t.timestamps
    end
  end
end
