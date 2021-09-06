class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :category, null: false
      t.tsvector :tsv_category
      t.tsvector :tsv_content
      t.string :status, null: false, default: 'draft'

      t.references :user, foreign_key: true, null: false, index: true

      t.timestamps
    end

    add_index :articles, :tsv_category, using: :gin
    add_index :articles, :tsv_content, using: :gin
  end
end
