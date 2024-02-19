class SubmissionSerializer < Panko::Serializer
  attributes :id, :student_id, :assignment_id, :url, :submission_status, :submitted_on, :student_name

  def student_name
    "#{object.student.first_name} #{object.student.last_name}"
  end
end