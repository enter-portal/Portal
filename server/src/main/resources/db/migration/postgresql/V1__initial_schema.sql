-- V1__initial_schema.sql

CREATE TABLE users
(
    id         UUID         NOT NULL PRIMARY KEY,
    email      VARCHAR(255) NOT NULL UNIQUE,
    username   VARCHAR(50)  NOT NULL UNIQUE,
    password   VARCHAR(255) NOT NULL,
    created_at TIMESTAMP    NOT NULL,
    updated_at TIMESTAMP    NOT NULL,
    deleted_at TIMESTAMP
);

CREATE TABLE files
(
    id           UUID         NOT NULL PRIMARY KEY,
    file_name    VARCHAR(255) NOT NULL,
    mime_type    VARCHAR(100) NOT NULL,
    size         BIGINT       NOT NULL,
    location     VARCHAR(500) NOT NULL,
    storage_type VARCHAR(50)  NOT NULL,
    created_at   TIMESTAMP    NOT NULL,
    deleted_at   TIMESTAMP
);

CREATE TABLE messages
(
    id               UUID        NOT NULL PRIMARY KEY,
    message          TEXT,
    message_type     VARCHAR(50) NOT NULL,
    file_id          UUID,
    sender_user_id   UUID        NOT NULL,
    receiver_user_id UUID        NOT NULL,
    status           VARCHAR(50) NOT NULL DEFAULT 'SENT',
    created_at       TIMESTAMP   NOT NULL,
    updated_at       TIMESTAMP   NOT NULL,
    deleted_at       TIMESTAMP,
    CONSTRAINT fk_sender FOREIGN KEY (sender_user_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT fk_receiver FOREIGN KEY (receiver_user_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT fk_file FOREIGN KEY (file_id) REFERENCES files (id) ON DELETE SET NULL
);

CREATE TABLE keys
(
    id                    UUID      NOT NULL PRIMARY KEY,
    public_key            TEXT      NOT NULL,
    encrypted_private_key TEXT      NOT NULL,
    user_id               UUID      NOT NULL UNIQUE,
    created_at            TIMESTAMP NOT NULL,
    updated_at            TIMESTAMP NOT NULL,
    deleted_at            TIMESTAMP,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

-- Indexes for users table
CREATE INDEX idx_users_active_username ON users (username text_pattern_ops) WHERE deleted_at IS NULL;
-- Indexes for messages table
CREATE INDEX idx_receiver_status_time ON messages (receiver_user_id, status, created_at);
CREATE INDEX idx_sender_time ON messages (sender_user_id, created_at);
CREATE INDEX idx_message_file ON messages (file_id);

-- Comments
COMMENT
ON TABLE users IS 'Stores user account information';
COMMENT
ON TABLE files IS 'Stores file metadata for messages';
COMMENT
ON TABLE messages IS 'Stores encrypted messages between users';
COMMENT
ON TABLE keys IS 'Stores public and encrypted private keys for users';