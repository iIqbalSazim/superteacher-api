class CreateClassrooms < ActiveRecord::Migration[7.1]
  def change
    create_table :classrooms do |t|
      t.references :teacher, foreign_key: { to_table: :users, on_delete: :cascade}, null: false 
      t.string :title
      t.string :subject
      t.string :meet_link
      t.time :class_time
      t.string :days, array: true, default: []

      t.timestamps
    end
  end
end
