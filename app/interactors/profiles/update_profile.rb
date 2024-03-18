class Profiles::UpdateProfile < BaseInteractor
  include Interactor

  REQUIRED_PARAMS = %i[params current_user].freeze

  FAILED_TO_UPDATE = "Failed to update profile"
  PROFILE_DOES_NOT_EXIST = "Profile does not exist"

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    validate_params REQUIRED_PARAMS
    
    profile_to_be_updated = find_profile_by_role

    if profile_to_be_updated.present?
      handle_update_profile(profile_to_be_updated)
    else
      context.fail!(
        message: PROFILE_DOES_NOT_EXIST
      )
    end
  end

  private

  def find_profile_by_role
    if current_user.teacher?
      TeacherProfileRepository.find_by_teacher_id(current_user.id)
    else
      StudentProfileRepository.find_by_student_id(current_user.id)
    end
  end

  def handle_update_profile(profile_to_be_updated)
    updated_profile = update_profile(profile_to_be_updated)

    if updated_profile.valid?
      context.profile = updated_profile
    else
      context.fail!(
        message: FAILED_TO_UPDATE
      )
    end
  end

  def update_profile(profile_to_be_updated)
    if current_user.teacher?
      TeacherProfileRepository.update(profile_to_be_updated, profile_params)
    else
      StudentProfileRepository.update(profile_to_be_updated, profile_params)
    end
  end

  def profile_params
    params.except(:role, :first_name, :last_name, :gender, :phone_number)
  end
end
