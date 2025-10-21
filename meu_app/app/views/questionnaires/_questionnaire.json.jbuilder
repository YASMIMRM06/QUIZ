json.extract! questionnaire, :id, :code, :title, :description, :duration_minutes, :created_at, :updated_at
json.url questionnaire_url(questionnaire, format: :json)
