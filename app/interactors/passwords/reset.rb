class Passwords::Reset < BaseInteractor
  include Interactor

  REQUIRED_PARAMS = %i[params current_user].freeze

  INVALID = "Invalid password"

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    validate_params REQUIRED_PARAMS

    user = User.find_by(id: current_user.id)

    if user.authenticate(params["old_password"])
        context.fail!(
          message: SOMETHING_WENT_WRONG
        ) unless user.update(password: params["new_password"])

    else
      context.fail!(
        message: INVALID,
        status: :unprocessable_entity
      )
    end
  end
end
