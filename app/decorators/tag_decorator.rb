# frozen_string_literal: true

class TagDecorator < SimpleDelegator
  def tags_select_values
    Tag.pluck(:name, :id)
  end
end
