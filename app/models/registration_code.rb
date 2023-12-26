class RegistrationCode < ApplicationRecord
    validates :code, presence: true
end
