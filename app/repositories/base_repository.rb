class BaseRepository
    KLASS_ERROR_MESSAGE = 'Raised from BaseRepository. Should be overridden.'
    DEFAULT_LOAD_LIMIT = 20

    class << self
        def find_all
            klass.all
        end

        def find_by_id!(object_id)
            klass.find(object_id)
        end

        def find_by_id(object_id)
            klass.where(id: object_id).first
        end

        def find_by_classroom_id(id)
            klass.where(classroom_id: id)
        end

        delegate :create, to: :klass

        delegate :new, to: :klass

        def update(object, params)
            object.update(params)

            object
        end

        def destroy(object)
            object.destroy
        end

        delegate :find_or_create_by, to: :klass

        private

        def klass
            raise KLASS_ERROR_MESSAGE
        end
    end
end