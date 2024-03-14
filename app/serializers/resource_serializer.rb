class ResourceSerializer < Panko::Serializer
  include Panko

  attributes :id, :title, :description, :resource_type, :classroom_id, :url, :created_at, :due_date, :assignment_id, :submissions

  def due_date
    if object.resource_type == "assignment"
      object.assignment.due_date
    else
      nil
    end
  end

  def assignment_id
    if object.resource_type == "assignment"
      object.assignment.id
    end
  end

  def submissions
    if object.resource_type == "assignment"
      ArraySerializer.new(object.assignment.submissions, each_serializer: SubmissionSerializer).to_a
    end
  end 
end