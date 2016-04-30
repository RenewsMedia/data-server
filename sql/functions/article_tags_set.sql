CREATE OR REPLACE FUNCTION article_tags_set (
  article INTEGER,
  tags    TEXT[]
) RETURNS VOID LANGUAGE plpgsql SECURITY DEFINER AS $$
  DECLARE
    c_tag TEXT;
  BEGIN
    DELETE
    FROM "article_tags"
    WHERE "article" = $1;

    FOREACH c_tag IN ARRAY $2 LOOP
      INSERT
      INTO "tags" ("id")
      VALUES (c_tag);

      INSERT
      INTO "article_tags" ("article", "tag")
      VALUES ($1, c_tag);
    END LOOP;
  END;
$$;