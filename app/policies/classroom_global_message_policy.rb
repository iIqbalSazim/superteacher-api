class ClassroomGlobalMessagePolicy < ApplicationPolicy
  def get_messages?
    (user.role == "teacher" && user_teacher_of_classroom?) || (user.role == "student" && student_enrolled_in_classroom?)
  end

  def create_message?
    (user.role == "teacher" && user_teacher_of_classroom?) || (user.role == "student" && student_enrolled_in_classroom?)
  end

  private

  def student_enrolled_in_classroom?
    ClassroomStudent.exists?(classroom_id: record.classroom_id, student_id: user.id)
  end
end
