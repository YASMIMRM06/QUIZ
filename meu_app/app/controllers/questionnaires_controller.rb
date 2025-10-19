class QuestionnairesController < ApplicationController
  before_action :authenticate_user!

  def index
    # Lista de questionários ou mensagem de boas-vindas
  end
end
