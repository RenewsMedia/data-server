CREATE OR REPLACE FUNCTION users_update (
  id      INTEGER,
  mail    TEXT,
  country TEXT,
  name    TEXT,
  surname TEXT
) RETURNS SETOF RECORD LANGUAGE plpgsql SECURITY DEFINER AS $$
  BEGIN
    UPDATE "users"
    SET "mail"    = $2,
        "country" = $3,
        "name"    = $4,
        "surname" = $5
    WHERE "id" = $1;

    RETURN QUERY EXECUTE users_read_by_id($1);
  END;
$$;