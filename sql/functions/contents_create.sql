CREATE OR REPLACE FUNCTION contents_create (
  type    TEXT,
  article INTEGER,
  url     TEXT,
  data    TEXT,
  c_order   INTEGER
) RETURNS INTEGER LANGUAGE plpgsql SECURITY DEFINER AS $$
  DECLARE
    id INTEGER DEFAULT -1;
    data_id INTEGER;
  BEGIN
    data_id := text_data_create($4);

    IF data_id THEN
      INSERT
      INTO "contents" ("type", "article", "url", "data", "order")
      VALUES ($1, $2, $3, data_id, $5)
      RETURNING "id" INTO id;

      IF NOT FOUND THEN
        id := -1;
      END IF;
    END IF;

    RETURN id;
  END;
$$;