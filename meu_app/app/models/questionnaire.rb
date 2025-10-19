class Questionnaire < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :user_answer_histories, dependent: :destroy
  has_many :user_results, dependent: :destroy

  validates :code, :title, presence: true
  validates :code, uniqueness: true
end