class ArticlesSearch < ActiveRecord::Base
  # self.primary_key = :id
  include PgSearch::Model

  self.primary_key = :article_id

  pg_search_scope(
    :tsv_search,
    against: [:term],
    using: {
      tsearch: { prefix: true, any_word: false, tsvector_column: 'tsv_term' },
      trigram: {
        threshold: 0.35
      }
    }
  )

  def readonly?
    true
  end
end