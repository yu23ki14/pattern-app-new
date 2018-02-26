class CreateExchartLabels < ActiveRecord::Migration[5.1]
  def change
    create_table :exchart_labels do |t|
      t.references :language
      t.text :label
      t.timestamps
    end
  end
end
