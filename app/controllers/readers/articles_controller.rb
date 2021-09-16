# frozen_string_literal: true

module Readers
  class ArticlesController < ApplicationController
    def index
      # @articles_search = ArticlesSearch.tsv_articles_search(params[:query]).with_pg_search_highlight
      @articles_searches = ArticlesSearch.tsv_articles_search(params[:query])
    end

    def show
      @articles_search = ArticlesSearch.find(params[:id])
    end
  end
end
