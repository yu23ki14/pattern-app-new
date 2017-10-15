class AddBooleanFavorite < ActiveRecord::Migration[5.1]
  def change
    add_column :favorites, :fav, :boolean, default: true
  end
end
