# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id           :bigint           not null, primary key
#  category     :string
#  tsv_category :tsvector
#  status       :string           default("draft"), not null
#  user_id      :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe Article, type: :model do # rubocop:disable RSpec/EmptyExampleGroup
end
