CREATE TABLE IF NOT EXISTS 'channel_roles' (
    'role'      VARCHAR(3) NOT NULL,
    'channel'   INTEGER NOT NULL,
    'user'      INTEGER NOT NULL,

    FOREIGN KEY ('role')    REFERENCES 'roles' ('code'),
    FOREIGN KEY ('channel') REFERENCES 'channels' ('id'),
    FOREIGN KEY ('user')    REFERENCES 'users' ('id'),
    PRIMARY KEY ('channel', 'user')
);