class QuestionnairesController < ApplicationController
  before_action :set_questionnaire, only: %i[show edit update destroy]

  def index
    @questionnaires = policy_scope(Questionnaire)
  end

  def show
    authorize @questionnaire
  end

  def new
    @questionnaire = Questionnaire.new
    authorize @questionnaire
  end

  def create
  @questionnaire = current_user.questionnaires.build(questionnaire_params)
  if @questionnaire.save
    redirect_to @questionnaire, notice: "Questionário criado com sucesso!"
  else
    render :new, status: :unprocessable_entity
  end
end

  def edit
    authorize @questionnaire
  end

  def update
    authorize @questionnaire
    if @questionnaire.update(questionnaire_params)
      redirect_to @questionnaire, notice: "Atualizado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    authorize @questionnaire
    @questionnaire.destroy
    redirect_to questionnaires_path, notice: "Excluído com sucesso."
  end

  private

  def set_questionnaire
    @questionnaire = Questionnaire.find(params[:id])
  end

  def questionnaire_params
    params.require(:questionnaire).permit(:code, :title, :description, :duration_minutes)
  end
end
