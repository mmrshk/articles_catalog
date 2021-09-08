class Article::ValidateForm
  include ActiveModel::Model

  attr_accessor :content, :category, :article_tags, :user, :article

  validates :category, :content, :article_tags, presence: true
  validate :user_is_admin?, :tag_ids_exists?

  private

  def user_is_admin?
    errors.add(:base, 'You are not authorised for this action') unless user.is_a?(Admin)
  end

  def tag_ids_exists?
    errors.add(:base, 'Tag ids invalid') unless article_tags[:tag_ids].all? { |tag_id| Tag.find_by(id: tag_id) }
  end
end