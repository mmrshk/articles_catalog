class CreateArticleTag < ActiveRecord::Migration[6.0]
  def change
    create_table :article_tags do |t|
      t.references :article, index: true, foreign_key: true, null: false
      t.references :tag, index: true, foreign_key: true, null: false

      t.timestamps
    end
  end
end
