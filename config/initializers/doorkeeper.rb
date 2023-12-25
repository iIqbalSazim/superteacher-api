Doorkeeper.configure do
  orm :active_record

  resource_owner_from_credentials do
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      user
    else
      nil
    end
  end

  grant_flows %w[password]

  allow_blank_redirect_uri true

  skip_authorization do
    true
  end

  # use_refresh_token
end
