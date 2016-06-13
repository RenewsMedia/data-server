CREATE OR REPLACE FUNCTION articles_update (
  aid     INTEGER,
  emitter INTEGER,
  title   TEXT,
  tags    TEXT[]
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
  DECLARE
    channel RECORD;
  BEGIN
    SELECT *
    INTO channel
    FROM "channels"
    WHERE "channels"."id" = (
      SELECT "articles"."channel"
      FROM "articles"
      WHERE "articles"."id" = $1
    );

    IF FOUND AND check_permissions(channel."id", $2, 'WRITE_POSTS') THEN
      UPDATE "articles"
      SET "title" = $3
      WHERE "articles"."id" = $1;

      IF FOUND THEN
        PERFORM article_tags_set($1, $4);
      END IF;

      RETURN FOUND;
    END IF;

    RETURN FALSE;
  END;
$$;