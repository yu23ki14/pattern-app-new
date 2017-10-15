class AddLanguageUid < ActiveRecord::Migration[5.1]
  def change
    add_column :languages, :uid, :integer
  end
end
