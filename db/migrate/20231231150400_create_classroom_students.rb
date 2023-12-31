class CreateClassroomStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :classroom_students do |t|
      t.belongs_to :classroom, null: false, foreign_key: { to_table: :classrooms, on_delete: :cascade }
      t.belongs_to :student, null: false, foreign_key: { to_table: :users, on_delete: :cascade }

      t.timestamps
    end
  end
end
