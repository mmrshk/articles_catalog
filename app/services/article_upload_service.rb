# frozen_string_literal: true

class ArticleUploadService
  def self.call(attachments, current_user)
    attachments.each_value do |attachment|
      article_upload = ArticleUpload.create!(attachment: attachment)
      ArticleAttachmentsUploadJob.perform_later(article_upload, current_user.id)
    end
  end
end
