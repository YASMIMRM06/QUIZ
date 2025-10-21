class UserResult < ApplicationRecord
  belongs_to :user
  belongs_to :questionnaire
end
