CREATE OR REPLACE FUNCTION comments_delete (
  сid INTEGER,
  emitter INTEGER
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
  BEGIN
    DELETE
    FROM "comments"
    WHERE "comments"."id" = $1 AND
          "comments"."author" = $2;

    RETURN FOUND;
  END;
$$;