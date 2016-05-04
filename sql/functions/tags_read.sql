CREATE OR REPLACE FUNCTION tags_read (
  status TEXT DEFAULT 'any'
) RETURNS SETOF "tags" LANGUAGE plpgsql SECURITY DEFINER AS $$
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
      WHERE "tags"."status" = $1::tag_status;
    END IF;
  END;
$$;