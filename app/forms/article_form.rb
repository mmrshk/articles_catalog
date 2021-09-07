# frozen_string_literal: true

class ArticleForm
  include ActiveModel::Model

  attr_accessor :content, :category, :user_id, :article_tags
  attr_reader :article

  validates :category, :content, :user_id, :article_tags, presence: true
  validate :user_is_admin?, :tag_ids_exists?

  def save
    return false if invalid?

    ActiveRecord::Base.transaction do
      create_article!
      create_article_tags!
      article.activate!
    rescue ActiveRecord::RecordInvalid => e
      errors.add(:base, e.message)
    end
  end

  private

  def user_is_admin?
    errors.add(:base, 'You are not authorised for this action') unless Admin.find_by(id: user_id)
  end

  def tag_ids_exists?
    errors.add(:base, 'Tag ids invalid') unless article_tags[:tag_ids].all? { |tag_id| Tag.find_by(id: tag_id) }
  end

  def create_article_tags!
    article_tags[:tag_ids].each { |tag_id| article.article_tags.create!(tag_id: tag_id) }
  end

  def create_article!
    @article = Article.create!(category: category, content: content, user_id: user_id)
  end
end
