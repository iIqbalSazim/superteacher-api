class GlobalMessageSerializer < Panko::Serializer
  attributes :id, :classroom_id, :text, :created_at, :updated_at, :user

  def user
    {
      first_name: object.user.first_name,
      last_name: object.user.last_name,
      email: object.user.email,
      role: object.user.role
    }
  end
end