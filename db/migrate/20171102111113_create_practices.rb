class CreatePractices < ActiveRecord::Migration[5.1]
  def change
    create_table :practices do |t|
      t.references :user, null: false
      t.references :language, null: false
      t.integer :pattern_no, null: false
      t.integer :did, default: 0
      t.string :comment
      t.boolean :done
      t.integer :limit, null: false
      t.integer :priority
      t.datetime :lastdate
      t.datetime :enddate
      t.timestamps
    end
  end
end
