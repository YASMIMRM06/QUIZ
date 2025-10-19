class UserAnswerHistory < ApplicationRecord
  belongs_to :user
  belongs_to :questionnaire
  belongs_to :question
  belongs_to :selected_option, class_name: 'QuestionOption'

  validates :answered_at, presence: true
end