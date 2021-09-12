# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article, only: %i[edit update]

  def new
    @form = Articles::CreateForm.new({}, current_user)
  end

  def create
    @form = Articles::CreateForm.new(articles_create_params, current_user)

    if @form.save
      redirect_to root_path, notice: 'New Article is created'
    else
      render :new
    end
  end

  def edit; end

  def update
    @form = Articles::UpdateForm.new(articles_update_params, current_user, @article)

    if @form.save
      redirect_to root_path, notice: 'Article is updated'
    else
      render :edit
    end
  end

  def destroy; end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def articles_create_params
    params.require(:article_create_form).permit(:content, :category, article_tags: [tag_ids: []])
  end

  def articles_update_params
    params.require(:article).permit(:content, :category, article_tags: [tag_ids: []])
  end
end
