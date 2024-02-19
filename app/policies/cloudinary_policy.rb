class CloudinaryPolicy < ApplicationPolicy
    def upload_file?
        true
    end
end
