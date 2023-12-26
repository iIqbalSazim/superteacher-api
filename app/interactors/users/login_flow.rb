class Users::LoginFlow
  include Interactor::Organizer

  organize Users::AuthenticateUser,
           Users::GenerateAccessToken
end
