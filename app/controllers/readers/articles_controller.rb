# frozen_string_literal: true

module Readers
  class ArticlesController < ApplicationController
    def index
      # @articles_search = ArticlesSearch.tsv_articles_search(params[:query]).with_pg_search_highlight
      @articles_searches = ArticlesSearch.tsv_articles_search(params[:query])
      # @articles_searches = ArticlesSearch.where(category: 'Cooking')
      # @articles_searches.
      # binding.pry
    end
  end
end
