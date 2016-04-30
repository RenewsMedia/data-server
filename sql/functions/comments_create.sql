CREATE OR REPLACE FUNCTION comments_create (
  author    INTEGER,
  text_data TEXT
) RETURNS INTEGER LANGUAGE plpgsql SECURITY DEFINER AS $$
  DECLARE
    data_id INTEGER;
    id INTEGER DEFAULT -1;
  BEGIN
    data_id := text_data_create($2);

    IF data_id <> -1 THEN
      INSERT
      INTO "comments" ("author", "data")
      VALUES ($1, data_id)
      RETURNING "id" INTO id;
    END IF;
  END;
$$;