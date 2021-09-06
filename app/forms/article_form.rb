# frozen_string_literal: true

class ArticleForm
  include ActiveModel::Model

  attr_accessor :content, :category, :user_id, :article_tags
  attr_reader :article

  validates :category, :content, :user_id, :article_tags, presence: true

  def submit
    return false if invalid?

    ActiveRecord::Base.transaction do
      persist_article!
      persist_article_tags!

      raise ActiveRecord::Rollback unless errors.empty?
    end

    true
  end

  private

  def persist_article!
    @article ||= Article.create!(category: category, content: content, user_id: user_id)
  end

  # for future create butch of articles tags
  def persist_article_tags!
    # article_tags.each { |tag_id| ArticleTag.create(article_id: article.id, ) }

    ArticleTag.create(article_id: article.id, tag_id: article_tags['tag_id'])
  end
end
