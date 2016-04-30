CREATE OR REPLACE FUNCTION channels_create (
  owner       INTEGER,
  name        TEXT,
  description TEXT
) RETURNS INTEGER LANGUAGE plpgsql SECURITY DEFINER AS $$
  DECLARE
    id INTEGER DEFAULT -1;
  BEGIN
    INSERT
    INTO "channels" ("owner", "name", "description")
    VALUES ($1, $2, $3)
    RETURNING "id" INTO id;

    RETURN id;
  END;
$$;