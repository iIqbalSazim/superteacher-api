class CreateTeacherProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :teacher_profiles do |t|
      t.integer :teacher_id
      t.string :highest_education_level
      t.string :major_subject
      t.text :subjects_to_teach

      t.timestamps
    end
    add_index :teacher_profiles, :teacher_id
  end
end
