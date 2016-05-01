CREATE OR REPLACE FUNCTION users_create (
  login    TEXT,
  password TEXT,
  mail     TEXT,
  country  TEXT,
  name     TEXT,
  surname  TEXT
) RETURNS SETOF RECORD LANGUAGE plpgsql SECURITY DEFINER AS $$
  DECLARE
      uid INTEGER;
  BEGIN
    INSERT
    INTO "users" ("login", "password", "mail", "country", "name", "surname")
    VALUES ($1, '', $3, $4, $5, $6)
    RETURNING "id" INTO uid;

    IF FOUND THEN
        PERFORM users_update_password(uid, $2);
    END IF;

    RETURN QUERY EXECUTE users_read_by_id(uid);
  END;
$$;