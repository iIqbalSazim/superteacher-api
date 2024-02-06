class Users::CreateUserProfile
  include Interactor

  REQUIRED_PARAMS = %i[user_params new_user].freeze

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    profile_data = UserProfile.new(profile_params)

    if profile_data.save
      context.user_data = new_user
      context.profile_data = profile_data
    else
      new_user.destroy
      context.fail!(
        message: "Failed to create #{role} profile",
        error: "User and profile creation failed",
        status: :unprocessable_entity
      )
    end
  end

  private

  def UserProfile
    role == "teacher" ? TeacherProfile : StudentProfile
  end

  def profile_params
    common_params.merge(role_specific_params)
  end

  def common_params
    { "#{role}_id".to_sym => new_user.id }
  end

  def role_specific_params
    case role
    when "teacher"
      {
        highest_education_level: user_params[:highest_education_level],
        major_subject: user_params[:major_subject],
        subjects_to_teach: user_params[:subjects_to_teach]
      }
    when "student"
      {
        education: user_params[:education],
        address: user_params[:address]
      }
    end
  end

  def role
    user_params[:role]
  end
end
