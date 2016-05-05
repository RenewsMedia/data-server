CREATE OR REPLACE FUNCTION channels_delete (
    id INTEGER,
    emitter INTEGER
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
  DECLARE
    tmp RECORD;
  BEGIN
    SELECT *
    INTO tmp
    FROM "channels"
    WHERE "channels"."id" = $1 AND
          "channels"."owner" = $2;

    IF NOT FOUND THEN
      RETURN FALSE;
    END IF;

    DELETE
    FROM "channels"
    WHERE "channels"."id" = $1;

    RETURN FOUND;
  END;
$$;