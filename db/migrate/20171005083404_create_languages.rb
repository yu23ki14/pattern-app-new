class CreateLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :languages do |t|
      t.string :lg_name
      t.string :lg_code

      t.timestamps
    end
  end
end
