class CloudinaryPolicy < ApplicationPolicy
    def generate_signature?
        true
    end
end
