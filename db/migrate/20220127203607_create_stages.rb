class CreateStages < ActiveRecord::Migration[6.1]
  def change
    create_table :stages do |t|
      t.string :name, null: false
      t.integer :project_id

      t.timestamps
    end
    add_index :stages, :project_id
  end
end
