CREATE OR REPLACE FUNCTION users_read_auth_info (
  u_login TEXT
) RETURNS SETOF RECORD LANGUAGE plpgsql SECURITY DEFINER AS $$
  BEGIN
    RETURN QUERY
      SELECT "users"."id", "users"."password"
      FROM "users"
      WHERE "users"."login" = $1;
  END;
$$;