# frozen_string_literal: true

class ArticleAttachmentsUploadJob < ApplicationJob
  queue_as :default

  def perform(attachment, current_user_id)
    ActiveRecord::Base.transaction do
      article = Article.create!(user_id: current_user_id)

      ArticleAttachment.create!(attachment: attachment, article: article)
      article.inactivate!
    rescue ActiveRecord::RecordInvalid => e
      puts e
    end
  end
end
