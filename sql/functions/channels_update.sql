CREATE OR REPLACE FUNCTION channels_update (
  id          INTEGER,
  name        TEXT,
  description TEXT
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
  BEGIN
    UPDATE "channels"
    SET "name"        = $2,
        "description" = $3
    WHERE "id" = $1;

    RETURN FOUND;
  END;
$$;