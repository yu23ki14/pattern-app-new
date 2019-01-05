class CreatePresentationStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :presentation_stocks do |t|
      t.references :user, index: true, foreign_key: true
      t.references :presentation_post, index: true, foreign_key: true
      t.timestamps
    end
  end
end
