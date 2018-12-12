class CreatePresentationUserInterests < ActiveRecord::Migration[5.2]
  def change
    create_table :presentation_user_interests do |t|
      t.references :user, null: false
      t.references :pattern, null: false
      t.timestamps
    end
  end
end
