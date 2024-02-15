class ResourceSerializer < Panko::Serializer
  attributes :id, :title, :description, :resource_type, :url, :created_at, :due_date

  def due_date
    if object.assignment? && object.assignment
      object.assignment.due_date
    else
      nil
    end
  end
end