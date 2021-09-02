class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :type, null: false
      t.string :content, null: false
      t.tsvector :tsv_type
      t.tsvector :tsv_content
      t.string :status, null: false, default: 'created'

      t.references :admin, foreign_key: true, null: false, index: true

      t.timestamps
    end

    add_index :articles, :tsv_type, using: :gin
    add_index :articles, :tsv_content, using: :gin
  end
end
