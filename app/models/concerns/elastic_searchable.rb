# frozen_string_literal: true

module ElasticSearchable
  extend ActiveSupport::Concern

  included do # rubocop:disable Metrics/BlockLength
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    settings index: { number_of_shards: 1 } do
      mappings dynamic: 'false' do
        indexes :category, analyzer: 'english'
      end
    end

    def as_indexed_json(_options = {}) # rubocop:disable Metrics/MethodLength
      as_json(
        only: %i[id category],
        include: {
          content: {
            only: [:body]
          },
          tags: {
            only: [:name]
          }
        }
      )
    end

    def search(query)
      {
        query: {
          multi_match: {
            query: query,
            fields: ['category', 'tags.name', 'content.body']
          }
        }
      }
    end
  end
end
