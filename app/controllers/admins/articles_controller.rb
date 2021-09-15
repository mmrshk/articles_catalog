# frozen_string_literal: true

class Admins::ArticlesController < ApplicationController
  before_action :set_article, only: %i[edit update destroy activate]

  def new
    @form = Articles::BaseForm.new({}, current_user)
  end

  def create
    @form = Articles::CreateForm.new(articles_params, current_user)

    if @form.save
      redirect_to root_path, notice: 'New Article is created'
    else
      render :new
    end
  end

  def edit
    @form = Articles::BaseForm.new({}, current_user)
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
      redirect_to root_path, notice: 'Article was activated'
    else
      flash[:notice] = @article.errors
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def articles_params
    params.require(:articles_base_form).permit(:content, :category, article_tags: [tag_ids: []])
  end
end
