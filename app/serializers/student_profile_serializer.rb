class StudentProfileSerializer < Panko::Serializer
  attributes :id, :education, :address, :created_at
end
