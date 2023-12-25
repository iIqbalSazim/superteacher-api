class CreateRegistrationCodes < ActiveRecord::Migration[7.1]
  def change
    create_table :registration_codes do |t|
      t.string :code
      t.boolean :is_used
      t.datetime :expires_at

      t.timestamps
    end
    add_index :registration_codes, :code
  end
end
