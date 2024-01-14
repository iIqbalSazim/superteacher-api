class ResourceSerializer < Panko::Serializer
  attributes :id, :title, :description, :resource_type, :url, :created_at
end
