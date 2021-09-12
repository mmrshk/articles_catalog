# frozen_string_literal: true

# == Schema Information
#
# Table name: article_attachments
#
#  id         :bigint           not null, primary key
#  name       :string
#  attachment :string
#  article_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ArticleAttachment < ApplicationRecord
  belongs_to :article

  mount_uploader :attachment, FileUploader
end
