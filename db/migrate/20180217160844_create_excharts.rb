class CreateExcharts < ActiveRecord::Migration[5.1]
  def change
    create_table :excharts do |t|
      t.references :user
      t.references :language
      t.jsonb :data1
      t.jsonb :data2
      t.timestamps
    end
  end
end
