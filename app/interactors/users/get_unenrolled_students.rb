class Users::GetUnenrolledStudents
  include Interactor

  def call
    classroom_id = context.classroom_id
    students = User.where(role: "student").where.not(
        id: Classroom.find_by(id: classroom_id).student_ids
      )

    if students.present?
      context.students = students
    else
      context.fail!( error: "Students not found", status: :unprocessable_entity)
    end
  end
end
