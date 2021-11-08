class RemoveFieldFromArticle < ActiveRecord::Migration[6.0]
  def change
    remove_column :articles, :tsv_content
  end
end
