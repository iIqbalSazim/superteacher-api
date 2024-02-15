class ExamSerializer < Panko::Serializer
  attributes :id, :title, :description, :created_at, :date
end