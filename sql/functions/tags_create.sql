CREATE OR REPLACE FUNCTION tags_craete (
  tags TEXT[]
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
  DECLARE
    tag_id TEXT;
  BEGIN
    FOREACH tag_id IN ARRAY tags LOOP
      INSERT
      INTO "tags" ("id")
      VALUES (tag_id);
    END LOOP;

--     todo
    RETURN TRUE;
  END;
$$;