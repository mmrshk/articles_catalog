# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id            :bigint           not null, primary key
#  category      :string
#  tsv_category  :tsvector
#  tsv_content   :tsvector
#  upload_errors :text             default([]), is an Array
#  status        :string           default("draft"), not null
#  user_id       :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Article < ApplicationRecord
  include AASM

  has_rich_text :content

  belongs_to :admin, foreign_key: 'user_id', inverse_of: :articles

  has_one :article_upload, dependent: :destroy
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags

  # DOC:
  # Lifecycle for 1 article:
  # draft -> active
  # Lifecycle for 2 or more articles:
  # draft -> in_process -> active
  # draft -> in_process -> failed -> in_process -> active
  # rubocop:disable Metrics/BlockLength
  aasm column: :status do
    state :draft, initial: true
    state :in_process
    state :failed
    state :active
    state :inactive

    event :in_process do
      transitions from: %i[draft failed], to: :in_process
    end

    event :fail do
      transitions from: :in_process, to: :failed
    end

    event :activate do
      transitions from: %i[draft in_process failed inactive], to: :active
    end

    event :inactivate do
      transitions from: %i[draft active], to: :inactive
    end
  end
  # rubocop:enable Metrics/BlockLength
end
