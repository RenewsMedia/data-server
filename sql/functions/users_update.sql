CREATE OR REPLACE FUNCTION users_update (
  id      INTEGER,
  mail    TEXT,
  country TEXT,
  name    TEXT,
  surname TEXT
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
  BEGIN
    UPDATE "users"
    SET "mail"    = $2,
        "country" = $3,
        "name"    = $4,
        "surname" = $5
    WHERE "id" = $1;

    RETURN FOUND;
  END;
$$;