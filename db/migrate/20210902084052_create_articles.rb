class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :category
      t.tsvector :tsv_category
      t.tsvector :tsv_content
      t.string :status, null: false, default: 'draft'

      t.references :user, foreign_key: true, null: false, index: true

      t.timestamps
    end
  end
end
