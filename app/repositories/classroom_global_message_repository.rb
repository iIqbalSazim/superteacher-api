class ClassroomGlobalMessageRepository < BaseRepository
    class << self
        private

        def klass
            ClassroomGlobalMessage
        end
    end
end