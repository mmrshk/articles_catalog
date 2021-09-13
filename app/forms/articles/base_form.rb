# frozen_string_literal: true

module Articles
  class BaseForm
    include ActiveModel::Model

    attr_accessor :content, :category, :article_tags, :user, :article, :tags

    validates :category, :content, :article_tags, presence: true
    validate :user_is_admin?, :tag_ids_exists?

    private

    def user_is_admin?
      errors.add(:base, 'You are not authorised for this action') unless user.is_a?(Admin)
    end

    def tag_ids_exists?
      @tags = []

      errors.add(:base, 'Tag ids invalid') unless article_tags[:tag_ids].all? do |tag_id|
        tag = Tag.find_by(id: tag_id)

        @tags << tag if tag

        tag
      end
    end
  end
end
