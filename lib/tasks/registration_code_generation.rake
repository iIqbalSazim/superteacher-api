namespace :registration_code do
  desc "generate registration code"
  task generate: :environment do
    email = ARGV[1]

    puts "Generating registration code..."

    if email.blank? || !valid_email?(email)
      puts "Failed to generate registration code. Please provide a valid email address."
      exit(1)
    end

    begin
      existing_user = User.find_by(email: email)

      if existing_user
        puts "Error: Email already exists in the User table."
        exit(1)
      end

      existing = RegistrationCode.find_by(email: email)

      if existing
        existing.update!(
          code: code = SecureRandom.hex(3),
          is_used: false,
          email: email,
          attempts_count: 3,
        )
      else
        RegistrationCode.create!(
          code: code = SecureRandom.hex(3),
          is_used: false,
          email: email,
        )
      end

      puts "Registration code generated for #{email}: #{code}"
      exit(0)
    rescue StandardError => e
      puts "An error occurred: #{e.message}"
    end
  end

  private

  def valid_email?(email)
    email =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  end
end