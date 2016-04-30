CREATE OR REPLACE FUNCTION channels_delete (
    id INTEGER
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
    BEGIN
        DELETE
          FROM "channels"
         WHERE "id" = $1;

        RETURN FOUND;
    END;
$$;