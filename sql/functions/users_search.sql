CREATE OR REPLACE FUNCTION users_search (
  s_query INTEGER
) RETURNS SETOF RECORD LANGUAGE plpgsql SECURITY DEFINER AS $$
  BEGIN
--     TODO: make separation by spaces
    RETURN QUERY
      SELECT *
      FROM "users"
      WHERE "users"."login"   ~ $1 OR
            "users"."name"    ~ $1 OR
            "users"."surname" ~ $1;
  END;
$$;