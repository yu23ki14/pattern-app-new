class AddOptionToPresentationPost < ActiveRecord::Migration[5.2]
  def change
    add_column :presentation_posts, :option, :jsonb
  end
end
