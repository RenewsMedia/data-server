CREATE OR REPLACE FUNCTION tags_update (
  tags VARCHAR[],
  status tag_status
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
  BEGIN
    UPDATE "tags"
    SET "status" = $2::tag_status
    WHERE "tags"."id" = ANY($1::VARCHAR[]);

    RETURN FOUND;
  END;
$$;