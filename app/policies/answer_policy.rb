class AnswerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def update?
    user ? record.user.id == user.id || user.admin? : false
  end

  def destroy?
    update?
  end

  def create?
    !user.nil?
  end
end
