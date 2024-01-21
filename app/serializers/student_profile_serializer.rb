class StudentProfileSerializer < Panko::Serializer
  attributes :id, :education, :address, :created_at

  has_one :student, serializer: UserSerializer
end
