CREATE OR REPLACE FUNCTION channel_roles_delegate (
  role    TEXT,
  channel INTEGER,
  user_id INTEGER
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
  BEGIN
    UPDATE "channel_roles"
    SET "role" = $1
    WHERE "channel" = $2 AND
          "user"    = $3;

    IF NOT FOUND THEN
      INSERT
      INTO "channel_roles" ("role", "channel", "user")
      VALUES ($1, $2, $3);
    END IF;

    RETURN FOUND;
  END;
$$;