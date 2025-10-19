class Question < ApplicationRecord
  belongs_to :questionnaire
  has_many :question_options, dependent: :destroy
  has_many :user_answer_histories, dependent: :destroy

  validates :enunciation, presence: true
end