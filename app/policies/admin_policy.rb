# frozen_string_literal: true

class AdminPolicy < ApplicationPolicy
  def show?
    admin?
  end
end
