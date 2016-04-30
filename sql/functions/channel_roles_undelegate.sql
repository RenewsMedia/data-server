CREATE OR REPLACE FUNCTION channel_roles_undelegate (
  channel INTEGER,
  user_id INTEGER
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
  BEGIN
    DELETE
    FROM "channel_roles"
    WHERE "channel" = $1 AND
          "user"    = $2;

    RETURN FOUND;
  END;
$$;