class UserResult < ApplicationRecord
  belongs_to :user
  belongs_to :questionnaire

  validates :correct_answers, :total_questions, :score, :submitted_at, presence: true
end