class CreateAssignments < ActiveRecord::Migration[7.1]
  def change
    create_table :assignments do |t|
      t.references :resource, null: false, foreign_key: { to_table: :resources, on_delete: :cascade }
      t.datetime :due_date

      t.timestamps
    end
  end
end
