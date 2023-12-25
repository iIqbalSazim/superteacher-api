if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create(name: "React", redirect_uri: "", scopes: "")
end
