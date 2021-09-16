# frozen_string_literal: true

class ArticlesSearchPolicy < ApplicationPolicy
  def index?
    reader?
  end

  def show?
    reader?
  end
end
