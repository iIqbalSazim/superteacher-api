class Users::CreateUserProfile < BaseInteractor
  include Interactor

  REQUIRED_PARAMS = %i[user_data user_params].freeze

  PROFILE_CREATION_FAILED = "User and profile creation failed"
  STUDENT_PROFILE_CREATION_FAILED = "Failed to create student profile"
  TEACHER_PROFILE_CREATION_FAILED = "Failed to create teacher profile"

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    validate_params REQUIRED_PARAMS

    profile_data = user_profile(profile_params)

    save_profile_data(profile_data)
  end

  private

  def user_profile(params)
    if role == "teacher"
      TeacherProfileRepository.new(params)
    else
      StudentProfileRepository.new(params)
    end
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
      if role == "teacher"
        context.fail!(
          message: TEACHER_PROFILE_CREATION_FAILED,
          status: :unprocessable_entity
        )
      else
        context.fail!(
          message: STUDENT_PROFILE_CREATION_FAILED,
          status: :unprocessable_entity
        )
      end

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