class Classrooms::GlobalMessages::BroadcastMessage < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[classroom_id new_message].freeze

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        serialized_message = GlobalMessageSerializer.new.serialize(new_message)

        BroadcastGlobalMessageJob.perform_now(classroom_id, serialized_message)
    end
end
