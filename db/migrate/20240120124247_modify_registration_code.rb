class ModifyRegistrationCode < ActiveRecord::Migration[7.1]
  def change
    remove_column :registration_codes, :expires_at, :datetime

    add_column :registration_codes, :email, :string
    add_column :registration_codes, :attempts_count, :integer, default: 3
  end
end
