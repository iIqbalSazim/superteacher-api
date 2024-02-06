class Users::CreateUserProfile < BaseInteractor
  include Interactor

  REQUIRED_PARAMS = %i[user_data user_params].freeze

  PROFILE_CREATION_FAILED = "User and profile creation failed"

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    validate_params REQUIRED_PARAMS

    profile_data = user_profile.new(profile_params)

    save_profile_data(profile_data)
  end

  private

  def user_profile
    role == "teacher" ? TeacherProfile : StudentProfile
  end

  def profile_params
    common_params.merge(role_specific_params)
  end

  def common_params
    { "#{role}_id".to_sym => user_data.id }
  end

  def role_specific_params
    if role == "teacher"
      teacher_params
    else
      student_params
    end
  end

  def save_profile_data(profile_data)
    handle_failed_to_create_profile unless profile_data.save

    context.profile_data = profile_data
  end

  def handle_failed_to_create_profile
      user_data.destroy
      context.fail!(
        message: "Failed to create #{role} profile",
        status: :unprocessable_entity
      )
  end

  def teacher_params
    user_params.slice(:highest_education_level, :major_subject, :subjects_to_teach)
  end

  def student_params
    user_params.slice(:education, :address)
  end

  def role
    user_params[:role]
  end
end