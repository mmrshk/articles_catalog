# frozen_string_literal: true

# == Schema Information
#
# Table name: article_tags
#
#  id         :bigint           not null, primary key
#  article_id :bigint           not null
#  tag_id     :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ArticleTag < ApplicationRecord
  belongs_to :article
  belongs_to :tag
end
