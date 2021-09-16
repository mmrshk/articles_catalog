# frozen_string_literal: true

class ArticleValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:base] << "Content can't be blank" if record.content.empty?
  end
end
