# frozen_string_literal: true

class ArticleAttachmentsUploadJob < ApplicationJob
  queue_as :uploaders

  def perform(article_upload, current_user_id)
    ActiveRecord::Base.transaction do
      article = Article.inactive.build(user_id: current_user_id, content: article_upload.attachment.read)
      article.upload_errors = ArticleValidator.new.validate(article)
      article.save!

      article_upload.destroy!
      ActionCable.server.broadcast('notice_channel', { id: article.id, content: 'article already procceeded' })
    rescue StandardError => e
      puts e
    end
  end
end
