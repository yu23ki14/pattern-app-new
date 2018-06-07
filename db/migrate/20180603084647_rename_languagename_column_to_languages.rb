class RenameLanguagenameColumnToLanguages < ActiveRecord::Migration[5.1]
  def change
    rename_column :languages, :lg_name, :lg_name_ja
    add_column :languages, :lg_name_en, :string
  end
end
