# frozen_string_literal: true

class ArticleUploadPolicy < ApplicationPolicy
  def new?
    admin?
  end

  def upload?
    admin?
  end
end
