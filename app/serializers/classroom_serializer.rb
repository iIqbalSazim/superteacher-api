class ClassroomSerializer < Panko::Serializer
  attributes :id, :teacher_id, :title, :subject, :class_time, :days
end
