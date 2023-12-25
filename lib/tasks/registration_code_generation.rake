namespace :registration_code do
  desc 'Generate a new registration code'
  task generate: :environment do
    code = SecureRandom.hex(3) 

    RegistrationCode.create!(
      code: code,
      is_used: false,
      expires_at: Time.current + 1.hour
    )

    puts code
  end
end