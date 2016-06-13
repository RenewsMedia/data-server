CREATE OR REPLACE FUNCTION comments_create (
  author    INTEGER,
  article   INTEGER,
  text_data TEXT,
  ref_id    INTEGER DEFAULT NULL
) RETURNS SETOF "comments" LANGUAGE plpgsql SECURITY DEFINER AS $$
  DECLARE
    data_id INTEGER;
    cid INTEGER DEFAULT -1;
  BEGIN
    data_id := text_data_create($3);

    IF data_id <> -1 THEN
      INSERT
      INTO "comments" ("ref_id", "author", "data")
      VALUES ($4, $1, data_id)
      RETURNING "id" INTO cid;

      IF cid <> -1 THEN
        INSERT
        INTO "article_comments" ("article", "comment")
        VALUES ($2, cid);

        RETURN QUERY
          SELECT *
          FROM "comments"
          WHERE "comments"."id" = cid
          LIMIT 1;
      END IF;
    END IF;
  END;
$$;