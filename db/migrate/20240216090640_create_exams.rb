class CreateExams < ActiveRecord::Migration[7.1]
  def change
    create_table :exams do |t|
      t.string :title, null: false
      t.text :description
      t.datetime :date, null: false
      t.references :classroom, foreign_key: { to_table: :classrooms, on_delete: :cascade }, null: false

      t.timestamps
    end
  end
end
