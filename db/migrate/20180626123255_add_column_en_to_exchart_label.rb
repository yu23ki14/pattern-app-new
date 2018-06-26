class AddColumnEnToExchartLabel < ActiveRecord::Migration[5.1]
  def change
    rename_column :exchart_labels, :label, :label_ja
    add_column :exchart_labels, :label_en, :text
  end
end
