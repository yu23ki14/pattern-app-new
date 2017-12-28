class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :project_name
      t.string :project_summary
      t.string :project_id, unique: true
      t.string :project_color
      t.timestamps
    end
  end
end