class CreateStudentProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :student_profiles do |t|
      t.integer :student_id
      t.string :education_level
      t.string :address

      t.timestamps
    end
    add_index :student_profiles, :student_id
  end
end
