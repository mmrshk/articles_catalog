# frozen_string_literal: true

module Articles
  class UpdateForm < Articles::BaseForm
    def save
      return false if invalid?

      ActiveRecord::Base.transaction do
        update_article!
        update_article_tags!
        destroy_article_upload!
      rescue ActiveRecord::RecordInvalid => e
        errors.add(:base, e.message)
      end
    end

    private

    def update_article_tags!
      article.article_tags.destroy_all
      create_article_tags!
    end

    def update_article!
      article.update!(category: category, content: content, status: 'active')
    end

    def destroy_article_upload!
      article.article_upload.destroy!
    end
  end
end
