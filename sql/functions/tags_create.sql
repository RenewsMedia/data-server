CREATE OR REPLACE FUNCTION tags_create (
  c_tags TEXT[]
) RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
  DECLARE
    tag_id TEXT;
  BEGIN
    FOREACH tag_id IN ARRAY c_tags LOOP
      INSERT INTO "tags" ("id")
      SELECT tag_id
      WHERE NOT EXISTS (SELECT 1 FROM "tags" WHERE "id" = tag_id);
    END LOOP;

--     todo
    RETURN TRUE;
  END;
$$;