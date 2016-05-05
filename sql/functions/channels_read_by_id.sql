CREATE OR REPLACE FUNCTION channels_read_by_id (
  cid INTEGER
) RETURNS SETOF "channels" LANGUAGE plpgsql SECURITY DEFINER AS $$
  BEGIN
    RETURN QUERY SELECT *
                 FROM "channels"
                 WHERE "channels"."id" = $1;
  END;
$$;