class QuestionOptionPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    user.admin? || (user.moderator? && record.question.questionnaire.user_id == user.id)
  end

  def new?
    user.admin? || user.moderator?
  end

  def edit?
    user.admin? || user.moderator?
  end

  def create?
    return true if user.admin?
    return false unless user.moderator?

    question = Question.find_by(id: record.question_id)
    question.present? && question.questionnaire.user_id == user.id
  end

  def update?
    user.admin? || (user.moderator? && record.question.questionnaire.user_id == user.id)
  end

  def destroy?
    user.admin? || (user.moderator? && record.question.questionnaire.user_id == user.id)
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.moderator?
        scope.joins(question: :questionnaire).where(questionnaires: { user_id: user.id })
      else
        scope.none
      end
    end 
  end
end
