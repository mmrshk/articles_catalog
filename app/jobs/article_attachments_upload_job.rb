# frozen_string_literal: true

class ArticleAttachmentsUploadJob < ApplicationJob
  queue_as :default

  def perform(article_upload, current_user_id)
    ActiveRecord::Base.transaction do
      article = Article.create!(user_id: current_user_id, content: article_upload.attachment.read)
      article.inactivate!
      article_upload.destroy!

      ActionCable.server.broadcast('notice_channel', { id: article.id, content: 'article already procceeded' })
    rescue ActiveRecord::RecordInvalid => e
      puts e
    end
  end
end
