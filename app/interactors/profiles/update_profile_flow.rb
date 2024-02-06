class Profiles::UpdateProfileFlow
    include Interactor::Organizer

    organize Profiles::UpdateUserDetails,
             Profiles::UpdateProfile
end
