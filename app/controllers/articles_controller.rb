# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index; end

  def show; end

  def new
    @form = ArticleForm.new
  end

  def create
    @form = ArticleForm.new(articles_params)

    if @form.save
      redirect_to root_path, notice: 'New Article is created'
    else
      render :new
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def articles_params
    params.require(:article_form).permit(:content, :user_id, :category, article_tags: [tag_ids: []])
  end
end
