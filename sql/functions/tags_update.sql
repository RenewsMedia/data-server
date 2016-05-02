CREATE OR REPLACE FUNCTION tags_update (
  tags VARCHAR[],
  status TAG_STATUS
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
  BEGIN
    UPDATE "tags"
    SET "status" = $2
    WHERE "tags"."id" IN($1);

    RETURN FOUND;
  END;
$$;