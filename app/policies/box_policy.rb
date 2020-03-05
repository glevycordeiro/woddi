class BoxPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
  true
  end

  def map?
    true
  end
end
