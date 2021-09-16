# frozen_string_literal: true

class ArticlePolicy < ApplicationPolicy
  def index?
    reader?
  end

  def show?
    reader?
  end

  def new?
    admin?
  end

  def create?
    admin?
  end

  def update?
    admin?
  end

  def destroy?
    admin?
  end

  def activate?
    admin?
  end
end
