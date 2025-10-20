class QuestionnairePolicy < ApplicationPolicy
  # Escopo que define quais registros o usuário pode ver
  class Scope < Scope
    def resolve
      if user.has_role?("Administrador")
        scope.all
      elsif user.has_role?("Professor")
        scope.where(user_id: user.id)
      else # Aluno
        scope.all # Ou filtrar apenas questionários ativos/publicados
      end
    end
  end

  def index?
    user.present?
  end

  def show?
    user.present?
  end

  def create?
    user.has_role?("Administrador") || user.has_role?("Professor")
  end

  def update?
    user.has_role?("Administrador") || (user.has_role?("Professor") && record.user_id == user.id)
  end

  def destroy?
    user.has_role?("Administrador") || (user.has_role?("Professor") && record.user_id == user.id)
  end
end
