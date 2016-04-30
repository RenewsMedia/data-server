CREATE OR REPLACE FUNCTION users_update_password (
  id       INTEGER,
  password TEXT
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
  BEGIN
    UPDATE "users"
    SET "password" = md5($2)
    WHERE "id" = $1;

    RETURN FOUND;
  END;
$$;