class CreateResources < ActiveRecord::Migration[7.1]
  def change
    create_table :resources do |t|
      t.string :title
      t.text :description
      t.string :resource_type
      t.string :url
      t.references :classroom, foreign_key: { to_table: :classrooms, on_delete: :cascade }, null: false

      t.timestamps
    end
  end
end
