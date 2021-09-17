SELECT
  articles.id AS article_id,
  articles.category AS category,
  articles.tsv_category AS tsv_category,
  action_text_rich_texts.body AS term,
  action_text_rich_texts.tsv_body AS tsv_term,
  tags.name AS tag_name,
  tags.tsv_name AS tsv_tag_name
FROM articles
JOIN action_text_rich_texts ON action_text_rich_texts.record_id = articles.id
  AND action_text_rich_texts.record_type = 'Article'
  AND action_text_rich_texts.name = 'content'
JOIN article_tags ON article_tags.article_id = articles.id
JOIN tags ON tags.id = article_tags.tag_id
