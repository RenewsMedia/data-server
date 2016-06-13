CREATE OR REPLACE FUNCTION contents_create (
  type    article_content,
  article INTEGER,
  url     TEXT,
  data    TEXT,
  c_order INTEGER
) RETURNS INTEGER LANGUAGE plpgsql SECURITY DEFINER AS $$
  DECLARE
    c_id INTEGER DEFAULT -1;
    data_id INTEGER;
  BEGIN
    DELETE
    FROM "text_data"
    WHERE "text_data"."id" IN(
      SELECT "contents"."data"
      FROM "contents"
      WHERE "contents"."article" = $2
    );

    DELETE
    FROM "contents"
    WHERE "contents"."article" = $2;

    data_id := text_data_create($4);

    IF data_id > -1 THEN
      INSERT
      INTO "contents" ("type", "article", "url", "data", "order")
      VALUES ($1, $2, $3, data_id, $5)
      RETURNING "id" INTO c_id;
    END IF;

    RETURN c_id;
  END;
$$;