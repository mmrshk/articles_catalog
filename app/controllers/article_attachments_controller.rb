# frozen_string_literal: true

class ArticleAttachmentsController < ApplicationController
  def new
    @form = ArticleAttachment.new
  end

  def upload
    params[:attachment].each_value do |attachment|
      ArticleAttachmentsUploadJob.perform_now(attachment, current_user.id)
      # ArticleAttachmentsUploadJob.set(wait: 1.minute).perform_later(attachment, current_user.id)
    end

    redirect_to root_path
  end
end
