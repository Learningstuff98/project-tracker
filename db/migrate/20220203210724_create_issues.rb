class CreateIssues < ActiveRecord::Migration[6.1]
  def change
    create_table :issues do |t|
      t.string :title, null: false
      t.integer :stage_id

      t.timestamps
    end
    add_index :issues, :stage_id
  end
end
