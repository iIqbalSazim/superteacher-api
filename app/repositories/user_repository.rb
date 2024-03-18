class UserRepository < BaseRepository
    class << self
        def find_user_by_email(email)
            klass.find_by(email: email)
        end

        def fetch_enrolled_students(ids)
            klass.where(role: "student")
                 .where(id: ids)
        end

        def fetch_unenrolled_students(ids)
            klass.where(role: "student")
                 .where.not(id: ids)
        end

        private

        def klass
            User
        end
    end
end