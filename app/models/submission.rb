class Submission < ApplicationRecord
  belongs_to :student, class_name: 'User'
  belongs_to :assignment

  enum submission_status: { pending: 'pending', submitted: 'submitted', late: 'late' }

  validates :student_id, presence: true
  validates :submitted_on, presence: true
  validates :url, presence: true, length: { maximum: 255 }
  validates :submission_status, presence: true

  before_validation :set_default_submission_status

  before_save :check_submission_status

  private

  def set_default_submission_status
    self.submission_status ||= :pending
  end

  def check_submission_status
    if self.submitted_on > assignment.due_date
      self.submission_status = :late
    else
      self.submission_status = :submitted
    end
  end
end
