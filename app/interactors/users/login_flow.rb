class Users::LoginFlow
  include Interactor::Organizer

  organize Users::AuthenticateUser
end
