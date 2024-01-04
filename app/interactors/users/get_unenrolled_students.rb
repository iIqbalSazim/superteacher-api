class Users::GetUnenrolledStudents
  include Interactor

  def call
    classroom_id = context.classroom_id
    students = User.where(role: "student").where.not(
      id: ClassroomStudent.where(classroom_id: classroom_id).pluck(:student_id)
      )

    if students.present?
      context.students = students
    else
      context.fail!( error: "Students not found", status: :unprocessable_entity)
    end
  end
end
