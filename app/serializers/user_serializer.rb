class UserSerializer < Panko::Serializer
  attributes :id, :email, :first_name, :last_name, :gender, :phone_number, :role
end