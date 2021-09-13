# frozen_string_literal: true

# == Schema Information
#
# Table name: article_uploads
#
#  id         :bigint           not null, primary key
#  attachment :string
#  article_id :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ArticleUpload < ApplicationRecord
  belongs_to :article, optional: true

  mount_uploader :attachment, FileUploader
end
