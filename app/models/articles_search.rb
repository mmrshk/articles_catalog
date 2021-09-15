# frozen_string_literal: true

# == Schema Information
#
# Table name: articles_searches
#
#  article_id   :bigint           primary key
#  category     :string
#  tsv_category :tsvector
#  term         :text
#  tsv_term     :tsvector
#  tag_name     :string
#  tsv_tag_name :tsvector
#
class ArticlesSearch < ApplicationRecord
  include PgSearch::Model

  self.primary_key = :article_id

  pg_search_scope(
    :tsv_articles_search,
    against: {
      category: 'A',
      tag_name: 'B',
      term: 'C'
    },
    using: {
      tsearch: {
        prefix: true,
        any_word: false,
        highlight: {
          StartSel: '<b>',
          StopSel: '</b>',
          MaxWords: 123,
          MinWords: 456,
          ShortWord: 4,
          HighlightAll: true,
          MaxFragments: 3,
          FragmentDelimiter: '&hellip;'
        },
        tsvector_column: %i[tsv_category tsv_tag_name tsv_term]
      },
      trigram: {
        threshold: 0.35
      }
    }
  )

  def readonly?
    true
  end
end
