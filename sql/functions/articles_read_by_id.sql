CREATE OR REPLACE FUNCTION articles_read_by_id (
  aid INTEGER,
  emitter INTEGER DEFAULT NULL
) RETURNS SETOF articles LANGUAGE plpgsql SECURITY DEFINER AS $$
  DECLARE
    channel channels;
  BEGIN
    SELECT *
    INTO channel
    FROM "channels"
    WHERE "channels"."id" = (
      SELECT "articles"."channel"
      FROM "articles"
      WHERE "articles"."id" = $1
    );

    IF $2 > 0 AND check_permissions(channel."id", $2, 'WRITE_POSTS') THEN
      RETURN QUERY
        SELECT *
        FROM "articles"
        WHERE "articles"."id" = $1;
    END IF;

    RETURN QUERY
      SELECT *
      FROM "articles"
      WHERE
        "articles"."id" = $1 AND
        "articles"."published" < now() AND
        NOT "articles"."hidden";
  END;
$$;