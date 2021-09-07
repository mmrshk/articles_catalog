class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :name, null: false, unique: true
      t.tsvector :tsv_name

      t.timestamps
    end
  end
end
