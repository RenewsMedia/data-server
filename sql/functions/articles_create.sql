CREATE OR REPLACE FUNCTION articles_create (
  channel INTEGER,
  author  INTEGER,
  title   TEXT,
  tags    TEXT[]
) RETURNS INTEGER LANGUAGE plpgsql SECURITY DEFINER AS $$
  DECLARE
    id INTEGER DEFAULT -1;
  BEGIN
    IF check_permissions($1, $2, 'WRITE_POSTS') THEN
      INSERT INTO "articles" ("channel", "author", "title")
      VALUES ($1, $2, $3)
      RETURNING "articles"."id" INTO id;

      IF FOUND THEN
        PERFORM article_tags_set(id, $4);
      ELSE
        id := -1;
      END IF;
    END IF;

    RETURN id;
  END;
$$;