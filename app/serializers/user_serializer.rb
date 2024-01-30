class UserSerializer < Panko::Serializer
  attributes :id, :email, :first_name, :last_name, :gender, :phone_number, :role, :profile

  def profile
    if object.role == 'teacher'
      object.teacher_profile.as_json
    elsif object.role == 'student'
      object.student_profile.as_json
    end
  end
end