# frozen_string_literal: true

# module Article
  class Article::UpdateForm
    include ActiveModel::Model

    attr_accessor :content, :category, :article_tags, :user, :article

    validates :category, :content, :article_tags, presence: true
    validate :user_is_admin?, :tag_ids_exists?

    def initialize(params, user, article)
      @article = article
      @user = user

      super(params)
    end

    def save
      return false if invalid?

      ActiveRecord::Base.transaction do
        update_article!
        update_article_tags!
      rescue ActiveRecord::RecordInvalid => e
        errors.add(:base, e.message)
      end
    end

    private

    def user_is_admin?
      errors.add(:base, 'You are not authorised for this action') unless user.is_a?(Admin)
    end

    def tag_ids_exists?
      errors.add(:base, 'Tag ids invalid') unless article_tags[:tag_ids].all? { |tag_id| Tag.find_by(id: tag_id) }
    end

    def update_article_tags!
      article.article_tags.destroy_all

      article_tags[:tag_ids].each { |tag_id| article.article_tags.create!(tag_id: tag_id) }
    end

    def update_article!
      article.update!(category: category, content: content)
    end
  end
# end
