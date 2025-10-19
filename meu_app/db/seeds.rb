# Limpar dados existentes (opcional - cuidado em produção!)
puts "Limpando dados existentes..."
UserRole.delete_all
UserAnswerHistory.delete_all
UserResult.delete_all
QuestionOption.delete_all
Question.delete_all
Questionnaire.delete_all
Role.delete_all
User.delete_all

# Criar Roles
puts "Criando roles..."
admin_role = Role.create!(title: "Administrador")
professor_role = Role.create!(title: "Professor") 
aluno_role = Role.create!(title: "Aluno")

# Criar Users
puts "Criando usuários..."
users = [
  {
    name: "Admin Silva",
    email: "admin@ifpr.edu.br",
    password: "123456",
    suap_id: "123456",
    roles: [admin_role]
  },
  {
    name: "Professor Oliveira",
    email: "prof.oliveira@ifpr.edu.br", 
    password: "123456",
    suap_id: "654321",
    roles: [professor_role]
  },
  {
    name: "Aluno Santos",
    email: "aluno.santos@ifpr.edu.br",
    password: "123456", 
    suap_id: "789012",
    roles: [aluno_role]
  },
  {
    name: "Aluna Costa",
    email: "aluna.costa@ifpr.edu.br",
    password: "123456",
    suap_id: "345678",
    roles: [aluno_role]
  }
]

users.each do |user_data|
  user = User.create!(
    name: user_data[:name],
    email: user_data[:email],
    password: user_data[:password],
    suap_id: user_data[:suap_id]
  )
  user.roles << user_data[:roles]
end

# Criar Questionnaires
puts "Criando questionários..."
questionnaires = [
  {
    code: "WEB-III-01",
    title: "Introdução ao Ruby on Rails",
    description: "Questionário sobre conceitos básicos de Ruby on Rails",
    duration_minutes: 30
  },
  {
    code: "WEB-III-02", 
    title: "Models e ActiveRecord",
    description: "Questionário sobre models, migrations e ActiveRecord",
    duration_minutes: 45
  }
]

questionnaires_data = questionnaires.map do |q_data|
  Questionnaire.create!(q_data)
end

# Criar Questions para o primeiro questionário
puts "Criando perguntas..."
questions_data = [
  {
    questionnaire: questionnaires_data[0],
    enunciation: "O que significa a sigla MVC em Ruby on Rails?",
    options: [
      { title: "Model View Controller", is_correct: true },
      { title: "Main Visual Component", is_correct: false },
      { title: "Multiple Variable Control", is_correct: false },
      { title: "Model Variable Controller", is_correct: false }
    ]
  },
  {
    questionnaire: questionnaires_data[0], 
    enunciation: "Qual comando é usado para criar uma nova migration?",
    options: [
      { title: "rails generate migration", is_correct: true },
      { title: "rails new migration", is_correct: false },
      { title: "rails create migration", is_correct: false },
      { title: "rails migration new", is_correct: false }
    ]
  },
  {
    questionnaire: questionnaires_data[1],
    enunciation: "O que é o ActiveRecord no Rails?",
    options: [
      { title: "Um ORM (Object-Relational Mapping)", is_correct: true },
      { title: "Um padrão de arquitetura", is_correct: false },
      { title: "Uma linguagem de programação", is_correct: false },
      { title: "Um servidor web", is_correct: false }
    ]
  },
  {
    questionnaire: questionnaires_data[1],
    enunciation: "Qual convenção é usada para nomes de tabelas no Rails?",
    options: [
      { title: "snake_case e plural", is_correct: true },
      { title: "CamelCase e singular", is_correct: false },
      { title: "PascalCase e plural", is_correct: false },
      { title: "kebab-case e singular", is_correct: false }
    ]
  }
]

questions_data.each do |q_data|
  question = Question.create!(
    questionnaire: q_data[:questionnaire],
    enunciation: q_data[:enunciation]
  )
  
  q_data[:options].each do |option_data|
    QuestionOption.create!(
      question: question,
      title: option_data[:title],
      is_correct: option_data[:is_correct]
    )
  end
end

# Criar User Results (exemplo)
puts "Criando resultados de usuários..."
aluno = User.find_by(email: "aluno.santos@ifpr.edu.br")
aluna = User.find_by(email: "aluna.costa@ifpr.edu.br")

UserResult.create!(
  user: aluno,
  questionnaire: questionnaires_data[0],
  correct_answers: 2,
  total_questions: 2,
  score: 100.0,
  submitted_at: Time.current
)

UserResult.create!(
  user: aluna, 
  questionnaire: questionnaires_data[0],
  correct_answers: 1,
  total_questions: 2,
  score: 50.0,
  submitted_at: Time.current
)

# Criar User Answer Histories (exemplo)
puts "Criando histórico de respostas..."
question1 = Question.first
correct_option = question1.question_options.find_by(is_correct: true)
incorrect_option = question1.question_options.where(is_correct: false).first

UserAnswerHistory.create!(
  user: aluno,
  questionnaire: questionnaires_data[0],
  question: question1,
  selected_option: correct_option,
  is_correct: true,
  answered_at: Time.current,
  question_snapshot: question1.enunciation
)

UserAnswerHistory.create!(
  user: aluna,
  questionnaire: questionnaires_data[0], 
  question: question1,
  selected_option: incorrect_option,
  is_correct: false,
  answered_at: Time.current,
  question_snapshot: question1.enunciation
)

puts "Seed finalizado com sucesso!"
puts "- #{Role.count} roles criadas"
puts "- #{User.count} usuários criados" 
puts "- #{Questionnaire.count} questionários criados"
puts "- #{Question.count} perguntas criadas"
puts "- #{QuestionOption.count} opções de resposta criadas"
puts "- #{UserResult.count} resultados criados"
puts "- #{UserAnswerHistory.count} históricos de resposta criados"