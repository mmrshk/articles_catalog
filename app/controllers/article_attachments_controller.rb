# frozen_string_literal: true

class ArticleAttachmentsController < ApplicationController
  def new
    @article_upload = ArticleUpload.new
  end

  def upload
    ArticleUploadService.call(params[:attachment], current_user)

    redirect_to root_path
  end
end
