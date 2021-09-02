# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id              :bigint           not null, primary key
#  category        :string           not null
#  tsv_category    :tsvector
#  content         :string           not null
#  tsv_content     :tsvector
#  status          :string           default("draft"), not null
#  default_user_id :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Article < ApplicationRecord
  belongs_to :admin, foreign_key: 'default_user_id', inverse_of: :article
  has_many :tags, dependent: :destroy

  validates :category, :content, presence: true
end
