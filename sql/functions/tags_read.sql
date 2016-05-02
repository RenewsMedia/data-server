CREATE OR REPLACE FUNCTION tags_read (
  status TEXT DEFAULT 'any'
) RETURNS SETOF RECORD LANGUAGE plpgsql SECURITY DEFINER AS $$
  BEGIN
    IF status = 'any' THEN
      RETURN QUERY
      SELECT *
      FROM "tags"
      WHERE "tags"."status" IN('new', 'approved');
    ELSE
      RETURN QUERY
      SELECT *
      FROM "tags"
      WHERE "tags"."status" = $1;
    END IF;
  END;
$$;