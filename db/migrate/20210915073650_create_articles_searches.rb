class CreateArticlesSearches < ActiveRecord::Migration[6.0]
  def change
    create_view :articles_searches
  end
end
