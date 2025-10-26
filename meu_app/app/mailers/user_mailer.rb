class UserMailer < ApplicationMailer
  default from: 'no-reply@meusite.com'  # e-mail padrão de envio

  # Método para enviar email de boas-vindas
  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000/login' # link para login
    mail(to: @user.email, subject: 'Bem-vindo ao nosso site!')
  end
end
