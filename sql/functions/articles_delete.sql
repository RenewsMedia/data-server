CREATE OR REPLACE FUNCTION articles_delete (
  a_id    INTEGER,
  emitter INTEGER
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
  DECLARE
    channel RECORD;
  BEGIN
    SELECT *
    INTO channel
    FROM "channels"
    WHERE "channels"."id" = (
      SELECT "articles"."channel" FROM "articles" WHERE "articles"."id" = $1
    );

    IF NOT check_permissions(channel."id", emitter, 'DELETE_POSTS') THEN
      RETURN FALSE;
    END IF;

    DELETE
    FROM "articles"
    WHERE "id" = $1;

    RETURN TRUE;
  END;
$$;