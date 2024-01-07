class Classrooms::FindClassroom
  include Interactor

  def call
    classroom_id = context.classroom_id

    classroom = Classroom.find_by(id: classroom_id)

    if classroom
        context.classroom = classroom
    else
        context.fail!(
          error: "Classroom not found",
          message: "Classroom does not exist in the database",
          status: :unprocessable_entity
        )
    end
  end
end
