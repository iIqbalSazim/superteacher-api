class CreatePasswordResetTokens < ActiveRecord::Migration[7.1]
  def change
    create_table :password_reset_tokens do |t|
      t.string :email
      t.string :code
      t.boolean :is_used, default: false

      t.timestamps
    end

    add_index :password_reset_tokens, :email
    add_index :password_reset_tokens, :code
  end
end
