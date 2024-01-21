class TeacherProfileSerializer < Panko::Serializer
  attributes :id, :highest_education_level, :major_subject, :subjects_to_teach, :created_at

  has_one :teacher, serializer: UserSerializer
end
