class CreatePresentationPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :presentation_posts do |t|
      t.references :user, null: false
      t.string :title, null: false
      t.string :reference
      t.string :reference_store
      t.string :link
      t.text :content, null: false
      
      t.timestamps
    end
  end
end
