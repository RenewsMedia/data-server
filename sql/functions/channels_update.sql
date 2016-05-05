CREATE OR REPLACE FUNCTION channels_update (
  cid         INTEGER,
  name        TEXT,
  description TEXT,
  emitter     INTEGER
) RETURNS SETOF "channels" LANGUAGE plpgsql SECURITY DEFINER AS $$
  BEGIN
    IF check_permissions(cid, emitter, 'CHANGE_INFO') THEN
      UPDATE "channels"
      SET "name"        = $2,
          "description" = $3
      WHERE "channels"."id" = $1;
    END IF;

    RETURN QUERY SELECT * FROM channels_read_by_id(cid);
  END;
$$;