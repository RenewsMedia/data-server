CREATE OR REPLACE FUNCTION users_read_by_id (
  id INTEGER
) RETURNS SETOF RECORD LANGUAGE plpgsql SECURITY DEFINER AS $$
  BEGIN
    RETURN QUERY
      SELECT "users".*
      FROM "users"
      WHERE "users"."id" = $1;
  END;
$$;