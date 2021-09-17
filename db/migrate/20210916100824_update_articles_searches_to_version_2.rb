class UpdateArticlesSearchesToVersion2 < ActiveRecord::Migration[6.0]
  def change
    update_view :articles_searches, version: 2, revert_to_version: 1
  end
end
