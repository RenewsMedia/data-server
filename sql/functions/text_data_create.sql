CREATE OR REPLACE FUNCTION text_data_create (
  data TEXT
) RETURNS INTEGER LANGUAGE plpgsql SECURITY DEFINER AS $$
  DECLARE
    id INTEGER DEFAULT -1;
  BEGIN
    INSERT
    INTO "text_data" ("data")
    VALUES ($1)
    RETURNING "id" INTO id;

    RETURN id;
  END;
$$;