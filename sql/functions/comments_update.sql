CREATE OR REPLACE FUNCTION comments_update (
  id        INTEGER,
  text_data TEXT
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
  DECLARE
    result BOOLEAN DEFAULT FALSE;
    data_id INTEGER;
  BEGIN
    SELECT INTO data_id "data"
    FROM "comments"
    WHERE "id" = $1;

    IF FOUND THEN
        result := text_data_update(data_id, $2);
    END IF;

    RETURN result;
    END;
$$;