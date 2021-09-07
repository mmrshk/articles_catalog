# frozen_string_literal: true

class ArticleForm
  include ActiveModel::Model

  attr_accessor :content, :category, :user_id, :article_tags
  attr_reader :article

  validates :category, :content, :user_id, :article_tags, presence: true

  def submit
    return false if invalid?

    ActiveRecord::Base.transaction do
      create_article!
      article.activate!
    rescue ActiveRecord::RecordInvalid => e
      errors.add(:base, e.message)
    end
  end

  private

  def create_article!
    @article = Article.create!(
      category: category,
      content: content,
      user_id: user_id,
      article_tags_attributes: prepared_article_tags_params
    )
  end

  def prepared_article_tags_params
    article_tags[:tag_ids].map { |tag_id| { tag_id: tag_id } }
  end
end
