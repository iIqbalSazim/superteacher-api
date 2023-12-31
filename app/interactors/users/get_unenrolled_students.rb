class Users::GetUnenrolledStudents
  include Interactor

  def call
    classroom_id = context.classroom_id
    students = User.where(role: "student").where.not(
      id: ClassroomStudent.where(classroom_id: classroom_id).pluck(:student_id)
      ).select(:id, :email, :first_name, :last_name, :gender, :phone_number)

    if students.present?
      context.students = students
    else
      context.fail!(message: "No students found", error: "Students not found", status: :unprocessable_entity)
    end
  end
end
