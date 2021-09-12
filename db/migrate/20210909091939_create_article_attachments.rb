class CreateArticleAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :article_attachments do |t|
      t.string :name
      t.string :attachment
      t.references :article, index: true, foreign_key: true, null: false

      t.timestamps
    end
  end
end
