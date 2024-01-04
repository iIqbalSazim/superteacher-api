class ClassroomSerializer < Panko::Serializer
  attributes :id, :title, :subject, :class_time, :days

  has_one :teacher, serializer: UserSerializer
end
