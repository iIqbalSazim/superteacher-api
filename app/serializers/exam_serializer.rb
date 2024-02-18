class ExamSerializer < Panko::Serializer
  attributes :id, :title, :classroom_id, :description, :created_at, :date
end