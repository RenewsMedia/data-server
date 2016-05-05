CREATE OR REPLACE FUNCTION channels_create (
  c_owner       INTEGER,
  name        TEXT,
  description TEXT
) RETURNS SETOF "channels" LANGUAGE plpgsql SECURITY DEFINER AS $$
  DECLARE
    cid INTEGER DEFAULT -1;
  BEGIN
    INSERT
    INTO "channels" ("owner", "name", "description")
    VALUES ($1, $2, $3)
    RETURNING "channels"."id" INTO cid;

    IF cid <> -1 THEN
      PERFORM channel_roles_delegate('adm', cid, c_owner);
    END IF;

    RETURN QUERY SELECT * FROM channels_read_by_id(cid);
  END;
$$;