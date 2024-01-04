class ClassroomGlobalMessageSerializer < Panko::Serializer
  attributes :id, :classroom_id,  :text, :created_at, :updated_at

  has_one :user, serializer: UserSerializer
end