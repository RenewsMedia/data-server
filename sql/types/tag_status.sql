DROP TYPE IF EXISTS TAG_STATUS;
CREATE TYPE TAG_STATUS AS ENUM ('new', 'approved', 'declined');