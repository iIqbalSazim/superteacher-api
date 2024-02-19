class Classrooms::Assignments::Submissions::CreateNewSubmissionFlow
  include Interactor::Organizer

    organize Shared::ValidateUserAccess,
             Classrooms::Assignments::Submissions::CreateNewSubmission
end
