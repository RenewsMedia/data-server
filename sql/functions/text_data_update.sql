CREATE OR REPLACE FUNCTION text_data_update (
  id   INTEGER,
  data TEXT
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
  BEGIN
    UPDATE "text_data"
    SET "data" = $2
    WHERE "id" = $1;

    RETURN FOUND;
  END;
$$;