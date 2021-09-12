# frozen_string_literal: true

module Articles
  class UpdateForm < Articles::BaseForm
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

    def update_article_tags!
      article.article_tags.destroy_all

      tags.each { |tag| article.article_tags.create!(tag: tag) }
    end

    def update_article!
      article.update!(category: category, content: content)
    end
  end
end
