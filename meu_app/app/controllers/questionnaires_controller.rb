class QuestionnairesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_questionnaire, only: %i[respond submit_answers result all_results show edit update destroy]

  # --- INÍCIO DO QUESTIONÁRIO ---
  def respond
    @questions = @questionnaire.questions.includes(:question_options)
    authorize @questionnaire, :respond?
  end

  # --- ENVIO DE TODAS AS RESPOSTAS ---
  def submit_answers
    authorize @questionnaire, :submit_answer?

    params[:answers]&.each do |question_id, option_id|
      question = @questionnaire.questions.find(question_id)
      next if UserAnswerHistory.exists?(user: current_user, question: question)

      option = QuestionOption.find(option_id)
      UserAnswerHistory.create!(
        user: current_user,
        questionnaire: @questionnaire,
        question: question,
        question_option_id: option.id,
        is_correct: option.is_correct,
        answered_at: Time.current
      )
    end

    calculate_result

    redirect_to result_questionnaire_path(@questionnaire), notice: "Questionário finalizado!"
  end

  # --- RESULTADO INDIVIDUAL ---
  def result
    @user_result = current_user.user_results.find_by(questionnaire: @questionnaire)
    unless @user_result
      redirect_to respond_questionnaire_path(@questionnaire), alert: "Nenhum resultado encontrado. Por favor, envie suas respostas."
      return
    end
  end

  # --- RESULTADOS DE TODOS OS ALUNOS (ADMIN/MODERATOR) ---
  def all_results
    unless current_user.admin? || current_user.moderator?
      redirect_to questionnaires_path, alert: "Você não tem permissão para ver os resultados de todos os alunos."
      return
    end

    @all_results = @questionnaire.user_results.includes(:user)
  end

  # --- CRUD DE QUESTIONÁRIOS ---
  def index
    @questionnaires = policy_scope(Questionnaire)
  end

  def show
    authorize @questionnaire
  end

  def new
    @questionnaire = Questionnaire.new(duration_minutes: 15)
    authorize @questionnaire
  end

  def edit
    authorize @questionnaire
  end

  def create
    @questionnaire = Questionnaire.new(questionnaire_params)
    authorize @questionnaire
    @questionnaire.user = current_user

    respond_to do |format|
      if @questionnaire.save
        format.html { redirect_to @questionnaire, notice: "Questionário criado com sucesso." }
        format.json { render :show, status: :created, location: @questionnaire }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @questionnaire.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @questionnaire
    respond_to do |format|
      if @questionnaire.update(questionnaire_params)
        format.html { redirect_to @questionnaire, notice: "Questionário atualizado com sucesso.", status: :see_other }
        format.json { render :show, status: :ok, location: @questionnaire }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @questionnaire.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @questionnaire
    @questionnaire.destroy!
    respond_to do |format|
      format.html { redirect_to questionnaires_path, notice: "Questionário excluído com sucesso.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_questionnaire
    @questionnaire = Questionnaire.find(params[:id])
  end

  def questionnaire_params
    params.require(:questionnaire).permit(:code, :title, :description, :duration_minutes)
  end

  # --- CALCULA RESULTADO DO USUÁRIO ---
  def calculate_result
    answers = current_user.user_answer_histories.where(questionnaire: @questionnaire)

    total = @questionnaire.questions.count
    correct = answers.select { |a| a.is_correct }.count
    percentage = ((correct.to_f / total) * 100).round(2)

    result = UserResult.find_or_initialize_by(user: current_user, questionnaire: @questionnaire)
    result.correct_answers = correct
    result.total_questions = total
    result.score = percentage
    result.submitted_at = Time.current
    result.save!
  end
end
