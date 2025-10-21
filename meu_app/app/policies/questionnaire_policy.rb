class QuestionnairePolicy < ApplicationPolicy

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

  def index?
    true
  end

  def show?
    true
  end

  def new?
    user.admin? || user.moderator?
  end

  def edit?
    user.admin? || (user.moderator? && record.user_id == user.id)
  end

  def create?
    user.admin? || user.moderator?
  end

  def update?
    user.admin? || (user.moderator? && record.user_id == user.id)
  end

  def destroy?
    user.admin? || (user.moderator? && record.user_id == user.id)
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.moderator?
        scope.where(user_id: user.id)
      else
        scope.none
      end
    end
  end
end
