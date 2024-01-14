class ClassroomSerializer < Panko::Serializer
  attributes :id, :title, :subject, :class_time, :days, :meet_link, :created_at

  has_one :teacher, serializer: UserSerializer
end
