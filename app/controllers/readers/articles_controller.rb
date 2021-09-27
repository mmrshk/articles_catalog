# frozen_string_literal: true

module Readers
  class ArticlesController < ApplicationController
    def index
      @articles_searches = ArticlesSearch.tsv_articles_search(params[:query])

      authorize @articles_searches
    end

    def search
      # @articles_searches = Article.__elasticsearch__.search(params[:query]).results

      @articles_searches = Article.__elasticsearch__.search(
        query: {
          multi_match: {
            query: params[:query],
            fields: ['category', 'author.first_name']
          }
        }
      ).results

      authorize @articles_searches, policy_class: ArticlesSearchPolicy
    end

    def show
      @articles_search = ArticlesSearch.find(params[:id])

      authorize @articles_search
    end
  end
end
