class QuestionnairesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_questionnaire, only: %i[
    respond question submit_answer result show edit update destroy
  ]

  def respond
    @first_question = @questionnaire.questions.first
    authorize @first_question
  end

  def question
    @question = @questionnaire.questions.find(params[:id])
    authorize @question
  end

  def submit_answer
    @question = @questionnaire.questions.find(params[:id])
    authorize @question

    # Evita respostas duplicadas
    already_answered = UserAnswerHistory.exists?(user: current_user, question: @question)
    unless already_answered
      question_option = QuestionOption.find_by(id: params[:option_id])
      UserAnswerHistory.create!(
        user: current_user,
        questionnaire: @questionnaire,
        question: @question,
        question_option_id: question_option.id,
        is_correct: question_option.is_correct,
        answered_at: Time.current
      )
    end

    # Ir para próxima questão ou finalizar
    next_question = @questionnaire.questions.where("id > ?", @question.id).first

    if next_question
      redirect_to question_questionnaire_path(@questionnaire, next_question)
    else
      calculate_result
      redirect_to result_questionnaire_path(@questionnaire), notice: "Questionário finalizado!"
    end
  end

  def result
    @user_result = current_user.user_results.find_by(questionnaire: @questionnaire)
    authorize @user_result
  end

  # GET /questionnaires
  def index
    @questionnaires = policy_scope(Questionnaire)
  end

  # GET /questionnaires/1
  def show
    authorize @questionnaire
  end

  # GET /questionnaires/new ✅ Tempo mínimo de 15 minutos definido automaticamente
  def new
    @questionnaire = Questionnaire.new(duration_minutes: 15)
    authorize @questionnaire
  end

  # GET /questionnaires/1/edit
  def edit
    authorize @questionnaire
  end

  # POST /questionnaires
  def create
    @questionnaire = Questionnaire.new(questionnaire_params)
    authorize @questionnaire
    @questionnaire.user = current_user

    respond_to do |format|
      if @questionnaire.save
        format.html { redirect_to @questionnaire, notice: "Questionnaire was successfully created." }
        format.json { render :show, status: :created, location: @questionnaire }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @questionnaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questionnaires/1
  def update
    authorize @questionnaire

    respond_to do |format|
      if @questionnaire.update(questionnaire_params)
        format.html { redirect_to @questionnaire, notice: "Questionnaire was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @questionnaire }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @questionnaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questionnaires/1
  def destroy
    authorize @questionnaire
    @questionnaire.destroy!

    respond_to do |format|
      format.html { redirect_to questionnaires_path, notice: "Questionnaire was successfully destroyed.", status: :see_other }
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

  def calculate_result
    answers = current_user.user_answer_histories.joins(:question_option).where(questions: { questionnaire_id: @questionnaire.id })

    total = @questionnaire.questions.count
    correct = answers.where(question_options: { is_correct: true }).count
    percentage = ((correct.to_f / total) * 100).round(2)

    UserResult.create!(
      user: current_user,
      questionnaire: @questionnaire,
      correct_answers: correct,
      total_questions: total,
      score: percentage,
      submitted_at: Time.current
    )
  end
end
