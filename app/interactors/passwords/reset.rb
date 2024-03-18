class Passwords::Reset < BaseInteractor
  include Interactor

  REQUIRED_PARAMS = %i[params current_user].freeze

  INVALID = "Invalid password"

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    validate_params REQUIRED_PARAMS

    user = UserRepository.find_by_id(current_user.id)

    if user.authenticate(params["old_password"])
        updated_user = UserRepository.update(user, { password: params["new_password"] })

        context.fail!(
          message: SOMETHING_WENT_WRONG
        ) unless updated_user.valid?

    else
      context.fail!(
        message: INVALID,
        status: :unprocessable_entity
      )
    end
  end
end
