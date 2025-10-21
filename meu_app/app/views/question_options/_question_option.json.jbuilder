json.extract! question_option, :id, :title, :is_correct, :question_id, :created_at, :updated_at
json.url question_option_url(question_option, format: :json)
