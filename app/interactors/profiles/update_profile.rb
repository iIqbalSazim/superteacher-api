class Profiles::UpdateProfile < BaseInteractor
  include Interactor

  REQUIRED_PARAMS = %i[params current_user].freeze

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    validate_params REQUIRED_PARAMS
    
    profile_to_be_updated = find_profile_by_role

    if profile_to_be_updated.present?
      profile_to_be_updated.update(profile_params)

      context.profile = profile_to_be_updated
    else
      context.fail!(
        message: "#{role.capitalize} profile does not exist in the database",
      )
    end
  end

  private

  def find_profile_by_role
    if current_user.teacher?
      TeacherProfile.find_by(teacher_id: current_user.id)
    else
      StudentProfile.find_by(student_id: current_user.id)
    end
  end

  def profile_params
    params.except(:role, :first_name, :last_name, :gender, :phone_number)
  end

  def role
    current_user[:role]
  end
end
