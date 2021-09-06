# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id           :bigint           not null, primary key
#  category     :string           not null
#  tsv_category :tsvector
#  tsv_content  :tsvector
#  status       :string           default("draft"), not null
#  user_id      :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Article < ApplicationRecord
  include AASM

  has_rich_text :content

  belongs_to :admin, foreign_key: 'user_id', inverse_of: :article
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags

  aasm column: :status do
    state :draft, initial: true
    state :processed
    state :failed
    state :retried
    state :activated

    event :in_process do
      transitions from: :draft, to: :processed
    end

    event :fail do
      transitions from: :processed, to: :failed
    end

    event :retry do
      transitions from: :failed, to: :retried
    end

    event :activate do
      transitions from: %i[processed retried], to: :activated
    end
  end
end
