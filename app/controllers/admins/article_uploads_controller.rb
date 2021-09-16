# frozen_string_literal: true

module Admins
  class ArticleUploadsController < ApplicationController
    def new
      @article_upload = ArticleUpload.new

      authorize @article_upload
    end

    def upload
      ArticleUploadService.call(params[:attachment], current_user)

      redirect_to root_path
    end
  end
end
