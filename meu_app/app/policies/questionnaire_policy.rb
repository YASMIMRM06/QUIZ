class QuestionnairePolicy < ApplicationPolicy
  
  # --- AÇÕES ESPECÍFICAS ---
  def respond?
    user.student?
  end

  def question?
    user.student?
  end

  def submit_answer?
    user.student?
  end

  def result?
    user.admin? || user.moderator? || (user.student? && record.user_id == user.id)
  end

  # --- VISUALIZAÇÃO ---
  def index?
    true # todos podem ver a lista
  end

  def show?
    true # todos podem abrir detalhes do questionário
  end

  # --- CRIAÇÃO E EDIÇÃO ---
  def new?
    user.admin? || user.moderator?
  end

  def create?
    user.admin? || user.moderator?
  end

  def edit?
    user.admin? || (user.moderator? && record.user_id == user.id)
  end

  def update?
    user.admin? || (user.moderator? && record.user_id == user.id)
  end

  # --- EXCLUSÃO ---
  def destroy?
    user.admin? || (user.moderator? && record.user_id == user.id)
  end

  # --- ESCOPO DE VISUALIZAÇÃO ---
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.moderator?
        scope.where(user_id: user.id)
      elsif user.student?
        # alunos podem ver todos os questionários disponíveis, mas não editar
        scope.all
      else
        scope.none
      end
    end
  end
end
