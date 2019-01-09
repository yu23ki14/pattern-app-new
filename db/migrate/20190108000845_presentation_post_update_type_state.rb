class PresentationPostUpdateTypeState < ActiveRecord::Migration[5.2]
  def change
    add_column :presentation_posts, :state, :integer
    add_column :presentation_posts, :post_type, :integer
    
    add_index :presentation_posts, :state
  end
end
