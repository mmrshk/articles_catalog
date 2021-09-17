class CreateArticleTag < ActiveRecord::Migration[6.0]
  def change
    create_table :article_tags do |t|
      t.references :article, foreign_key: true, null: false, index: false
      t.references :tag, foreign_key: true, null: false

      t.timestamps
    end

    add_index :article_tags, [:article_id, :tag_id], unique: true
  end
end
