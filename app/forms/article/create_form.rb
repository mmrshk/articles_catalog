# frozen_string_literal: true

# module Article
  class Article::CreateForm
    include ActiveModel::Model

    attr_accessor :content, :category, :article_tags, :article, :user

    validates :category, :content, :article_tags, presence: true
    validate :user_is_admin?, :tag_ids_exists?

    def initialize(params, user)
      @user = user

      super(params)
    end

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
      errors.add(:base, 'You are not authorised for this action') unless user.is_a?(Admin)
    end

    def tag_ids_exists?
      errors.add(:base, 'Tag ids invalid') unless article_tags[:tag_ids].all? { |tag_id| Tag.find_by(id: tag_id) }
    end

    def create_article_tags!
      article_tags[:tag_ids].each { |tag_id| article.article_tags.create!(tag_id: tag_id) }
    end

    def create_article!
      @article = Article.create!(category: category, content: content, user_id: user.id)
    end
  end
# end
