# frozen_string_literal: true

module Articles
  class BaseFormPolicy < ApplicationPolicy
    def new?
      admin?
    end

    def edit?
      admin?
    end

    def create?
      admin?
    end
  end
end
