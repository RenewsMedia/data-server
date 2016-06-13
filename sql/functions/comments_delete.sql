CREATE OR REPLACE FUNCTION comments_delete (
  сid INTEGER,
  emitter INTEGER
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
  DECLARE
    channel RECORD;
    com RECORD;
  BEGIN
    SELECT *
    INTO channel
    FROM "channels"
    WHERE "channels"."id" = (
      SELECT "articles"."channel"
      FROM "articles"
      WHERE "articles"."id" = (
        SELECT "article_comments"."article"
        FROM "article_comments"
        WHERE "comment" = $1
      )
    );

    SELECT *
    INTO com
    FROM "comments"
    WHERE "comments"."id" = $1;

    IF com."author" = $2 OR check_permissions("channel"."id", emitter, 'DELETE_COMMENTS') THEN
      DELETE
      FROM "text_data"
      WHERE "text_data"."id" = (
        SELECT "comments"."data"
        FROM "comments"
        WHERE "id" = $1
      );

      DELETE
      FROM "comments"
      WHERE "comments"."id" = $1;

      RETURN FOUND;
    END IF;

    RETURN FALSE;
  END;
$$;