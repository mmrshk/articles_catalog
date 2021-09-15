class AddArticleSearchTriggers < ActiveRecord::Migration[6.0]
  def up
    add_index :articles, :tsv_category, using: :gin
    add_index :articles, :tsv_content, using: :gin
    add_index :action_text_rich_texts, :tsv_body, using: :gin
    add_index :tags, :tsv_name, using: :gin

    execute <<-SQL
      CREATE TRIGGER tsvectorarticlescategoryupdate BEFORE INSERT OR UPDATE
      ON articles FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(tsv_category, 'pg_catalog.simple', category);

      CREATE TRIGGER tsvectoractiontextrichtextsupdate BEFORE INSERT OR UPDATE
      ON action_text_rich_texts FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(tsv_body, 'pg_catalog.simple', body);

      CREATE TRIGGER tsvectortagsnameupdate BEFORE INSERT OR UPDATE
      ON tags FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(tsv_name, 'pg_catalog.simple', name);
    SQL

    now = Time.current.to_s(:db)
    update("UPDATE articles SET updated_at = '#{now}'")
    update("UPDATE action_text_rich_texts SET updated_at = '#{now}'")
    update("UPDATE tags SET updated_at = '#{now}'")
  end

  def down
    execute <<-SQL
      DROP TRIGGER tsvectorarticlescategoryupdate ON articles;

      DROP TRIGGER tsvectoractiontextrichtextsupdate ON action_text_rich_texts;

      DROP TRIGGER tsvectortagsnameupdate ON tags;
    SQL

    remove_index :articles, :tsv_category, using: :gin
    remove_index :articles, :tsv_content, using: :gin
    remove_index :action_text_rich_texts, :tsv_body, using: :gin
    remove_index :tags, :tsv_name, using: :gin
  end
end
