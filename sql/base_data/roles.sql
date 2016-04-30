INSERT INTO "roles" ("code", "name", "access") VALUES
('adm', 'Administrator',    ARRAY['ALL']),
('edi', 'Editor',           ARRAY['WRITE_POSTS', 'DELETE_POSTS']),
('sma', 'Social manager',   ARRAY['FEEDBACK_MANAGEMENT', 'DELETE_COMMENTS']);