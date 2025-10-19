class QuestionOption < ApplicationRecord
  belongs_to :question
  has_many :user_answer_histories, foreign_key: :selected_option_id, dependent: :nullify

  validates :title, presence: true
end