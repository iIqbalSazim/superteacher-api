class Classrooms::Assignments::Submissions::DeleteSubmissionFlow
  include Interactor::Organizer

    organize Shared::ValidateUserAccess,
             Classrooms::Assignments::Submissions::DeleteSubmission
end
