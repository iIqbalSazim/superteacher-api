class StudentProfiles::UpdateStudentProfileFlow
    include Interactor::Organizer

    organize Shared::UpdateUserDetails,
             StudentProfiles::UpdateStudentProfile
end
