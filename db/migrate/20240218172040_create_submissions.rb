class CreateSubmissions < ActiveRecord::Migration[7.1]
  def change
    create_table :submissions do |t|
      t.references :student, foreign_key: { to_table: :users, on_delete: :cascade }, null: false
      t.references :assignment, foreign_key: { to_table: :assignments, on_delete: :cascade }, null: false
      t.datetime :submitted_on
      t.string :url
      t.string :submission_status

      t.timestamps
    end

    add_index :submissions, [:student_id, :assignment_id], unique: true
  end
end
