class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.references :user
      t.references :language
      t.string :event_code, :unique => true
      t.string :event_name
      t.jsonb :other_details
      t.datetime :limit
      t.timestamps
    end
  end
end
