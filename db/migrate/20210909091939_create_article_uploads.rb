class CreateArticleUploads < ActiveRecord::Migration[6.0]
  def change
    create_table :article_uploads do |t|
      t.string :attachment
      t.references :article, index: true, foreign_key: true, null: true

      t.timestamps
    end
  end
end
