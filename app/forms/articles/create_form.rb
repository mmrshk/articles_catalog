# frozen_string_literal: true

module Articles
  class CreateForm < Articles::BaseForm
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

    def create_article_tags!
      article_tags[:tag_ids].each { |tag_id| article.article_tags.create!(tag_id: tag_id) }
    end

    def create_article!
      @article = Article.create!(category: category, content: content, user_id: user.id)
    end
  end
end
