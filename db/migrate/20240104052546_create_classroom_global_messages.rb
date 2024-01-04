class CreateClassroomGlobalMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :classroom_global_messages do |t|
      t.references :classroom, foreign_key: { to_table: :classrooms, on_delete: :cascade }, null: false
      t.references :user, foreign_key: { to_table: :users, on_delete: :cascade}, null: false 
      t.text :text

      t.timestamps
    end
  end
end
