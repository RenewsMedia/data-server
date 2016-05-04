CREATE OR REPLACE FUNCTION users_read_by_id (
  id INTEGER
) RETURNS SETOF "users" LANGUAGE plpgsql SECURITY DEFINER AS $$
  BEGIN
    RETURN QUERY
      SELECT *
      FROM "users"
      WHERE "users"."id" = $1;
  END;
$$;