class CreatePresentationPostComments < ActiveRecord::Migration[5.2]
  def change
    create_table :presentation_post_comments do |t|
      t.text :comment, null: false
      t.references :presentation_post, null: false
      t.references :user, null: false
      
      t.timestamps
    end
  end
end
