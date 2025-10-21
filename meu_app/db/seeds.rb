# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Role.find_or_create_by(title: "admin")
Role.find_or_create_by(title: "moderator")
Role.find_or_create_by(title: "student")

admin = User.create!(
  name: "Administrador",
  email: "admin@exemplo.com",
  password: "123456",
  role: Role.find_by(title: "admin")
)

moderator = User.create!(
  name: "Moderador",
  email: "moderador@exemplo.com",
  password: "123456",
  role: Role.find_by(title: "moderator")
)

student = User.create!(
  name: "Aluno",
  email: "aluno@exemplo.com",
  password: "123456",
  role: Role.find_by(title: "student")
)