# frozen_string_literal: true

module Admins
  class ArticlesController < ApplicationController
    before_action :set_article, only: %i[edit update destroy activate]

    def new
      @form = Articles::BaseForm.new({}, current_user)

      authorize @form
    end

    def create
      @form = Articles::CreateForm.new(articles_params, current_user)

      authorize @form, policy_class: Articles::BaseFormPolicy

      if @form.save
        redirect_to root_path, notice: 'New Article is created'
      else
        render :new
      end
    end

    def edit
      @form = Articles::BaseForm.new({}, current_user)

      authorize @form
    end

    def update
      @form = Articles::UpdateForm.new(articles_params, current_user, @article)

      if @form.save
        redirect_to root_path, notice: 'Article is updated'
      else
        render :edit
      end
    end

    def destroy
      if @article.destroy!
        redirect_to root_path, notice: 'Article is deleted'
      else
        flash[:notice] = @article.errors
      end
    end

    def activate
      if @article.activate!
        redirect_to root_path, notice: 'Article is activated'
      else
        flash[:notice] = @article.errors
      end
    end

    private

    def set_article
      @article = Article.find(params[:id])

      authorize @article
    end

    def articles_params
      params.require(:articles_form).permit(:content, :category, article_tags: [tag_ids: []])
    end
  end
end
