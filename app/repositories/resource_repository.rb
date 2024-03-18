class ResourceRepository < BaseRepository
    class << self
        private

        def klass
            Resource
        end
    end
end