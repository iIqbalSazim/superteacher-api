class CloudinaryPolicy < ApplicationPolicy
    def upload_file?
        user.teacher?
    end
end
