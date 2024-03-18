class AssignmentRepository < BaseRepository
    class << self
        private

        def klass
            Assignment
        end
    end
end