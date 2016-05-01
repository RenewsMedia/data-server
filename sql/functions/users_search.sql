CREATE OR REPLACE FUNCTION users_search (
  s_query INTEGER
) RETURNS SETOF RECORD LANGUAGE plpgsql SECURITY DEFINER AS $$
  DECLARE
    parts VARCHAR[];
    part VARCHAR;
    c_match RECORD;
  BEGIN
    parts := string_to_array(s_query, ' ');

    FOREACH part IN ARRAY parts LOOP
      FOR c_match IN
        SELECT *
        FROM "users"
        WHERE "users"."login"   ~ $1 OR
              "users"."name"    ~ $1 OR
              "users"."surname" ~ $1
      LOOP
        RETURN NEXT c_match;
      END LOOP;
    END LOOP;

    RETURN;
  END;
$$;