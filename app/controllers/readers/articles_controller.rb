# frozen_string_literal: true

module Readers
  class ArticlesController < ApplicationController
    def index
      @articles_searches = ArticlesSearch.tsv_articles_search(params[:query])

      authorize @articles_searches
    end

    def show
      @articles_search = ArticlesSearch.find(params[:id])

      authorize @articles_search
    end
  end
end
