class CreateStudentProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :student_profiles do |t|
      t.references :student, foreign_key: { to_table: :users, on_delete: :cascade}, null: false
      t.json :education
      t.string :address

      t.timestamps
    end
  end
end
