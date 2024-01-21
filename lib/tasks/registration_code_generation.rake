namespace :registration_code do
  desc 'Generate a new registration code'
  task generate: :environment do
    email = ENV['EMAIL']
    code = SecureRandom.hex(3) 

    RegistrationCode.create!(
      code: code,
      is_used: false,
      email: email,
    )

    puts code
  end
end