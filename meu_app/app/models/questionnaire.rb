class Questionnaire < ApplicationRecord
    belongs_to :user
    has_many :questions, dependent: :destroy
    has_many :user_answer_histories, dependent: :destroy
    has_many :user_results, dependent: :destroy
end
