class CreateTeacherProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :teacher_profiles do |t|
      t.references :teacher, foreign_key: { to_table: :users, on_delete: :cascade}, null: false
      t.string :highest_education_level
      t.string :major_subject
      t.text :subjects_to_teach, array: true, default: []

      t.timestamps
    end
  end
end
