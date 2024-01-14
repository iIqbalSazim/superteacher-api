class CloudinaryPolicy < ApplicationPolicy
    def upload_file?
        user.role == "teacher"
    end
end
