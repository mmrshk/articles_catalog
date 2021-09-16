# frozen_string_literal: true

class ArticleAttachmentsUploadJob < ApplicationJob
  queue_as :uploaders

  def perform(article_upload, current_user_id)
    ActiveRecord::Base.transaction do
      article = Article.inactive.create!(user_id: current_user_id, content: article_upload.attachment.read)
      update_or_destroy_article_upload!(article, article_upload)

      ActionCable.server.broadcast('notice_channel', { id: article.id, content: 'article already procceeded' })
    end
  end

  private

  def update_or_destroy_article_upload!(article, article_upload)
    validator = ArticleValidator.new.validate(article)

    if article.errors.empty?
      article_upload.destroy!
    else
      article_upload.update!(article: article, upload_errors: validator)
    end
  end
end
