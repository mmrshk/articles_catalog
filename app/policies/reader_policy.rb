# frozen_string_literal: true

class ReaderPolicy < ApplicationPolicy
  def show?
    reader?
  end
end
