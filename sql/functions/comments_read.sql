CREATE OR REPLACE FUNCTION comments_read (
  aid INTEGER
) RETURNS TABLE (
  id INTEGER,
  published TIMESTAMP,
  author INTEGER,
  text VARCHAR(5000)
) LANGUAGE plpgsql SECURITY DEFINER AS $$
  BEGIN
    RETURN QUERY
      SELECT co."id", co."published", co."author", td."data" as "text"
      FROM "comments" co, "text_data" td
      WHERE td."id" = co."data" AND
        co."id" IN(
        SELECT "article_comments"."comment"
        FROM "article_comments"
        WHERE "article_comments"."article" = $1
      )
      ORDER BY co."published";
  END;
$$;