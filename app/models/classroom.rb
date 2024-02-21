class Classroom < ApplicationRecord
    belongs_to :teacher, class_name: 'User'

    has_many :classroom_global_messages, dependent: :destroy
    has_many :classroom_students, dependent: :destroy
    has_many :resources, dependent: :destroy

    has_many :students, class_name: 'User', through: :classroom_students

    validates :teacher, presence: true
    validates :title, presence: true, length: { maximum: 255 }
    validates :subject, presence: true, length: { maximum: 255 }
    validates :class_time, presence: true, length: { maximum: 255 }
    validates :days, presence: true, length: { minimum: 1, maximum: 7 }

    validate :validate_days_format

    private

    def validate_days_format
        return if days.nil?
        
        valid_days = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday]

        days.each do |day|
            errors.add(:days, "invalid day: #{day}") unless valid_days.include?(day)
        end
    end
end