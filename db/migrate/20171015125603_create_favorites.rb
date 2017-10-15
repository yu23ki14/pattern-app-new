class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.references :user_id, null: false
      t.references :lg_code, null: false
      t.references :pattern_no, null: false
      t.timestamps null: false
    end
  end
end
