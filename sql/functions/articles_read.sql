CREATE OR REPLACE FUNCTION articles_read (
  channel INTEGER,
  emitter INTEGER DEFAULT NULL
) RETURNS SETOF articles LANGUAGE plpgsql SECURITY DEFINER AS $$
  DECLARE
    a_temp articles;
  BEGIN
    IF $2 > 0 AND check_permissions($1, $2, 'WRITE_POSTS') THEN
      RETURN QUERY
        SELECT *
        FROM "articles"
        WHERE "channel" = $1;
    END IF;

    RETURN QUERY
      SELECT *
      FROM "articles"
      WHERE
        "articles"."published" > now() AND
        NOT "articles"."hidden";
  END;
$$;