class CreateAssignees < ActiveRecord::Migration[6.1]
  def change
    create_table :assignees do |t|
      t.string :assignee_username, null: false
      t.integer :assignee_id
      t.integer :issue_id

      t.timestamps
    end
    add_index :assignees, :issue_id
  end
end
