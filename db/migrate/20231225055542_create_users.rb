class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.string :phone_number

      t.timestamps
    end
    add_index :users, :email
  end
end
