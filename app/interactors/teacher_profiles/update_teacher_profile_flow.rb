class TeacherProfiles::UpdateTeacherProfileFlow
    include Interactor::Organizer

    organize Shared::UpdateUserDetails,
             TeacherProfiles::UpdateTeacherProfile
end
