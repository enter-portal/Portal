-- V1__initial_schema.sql

-- Create enums
CREATE TYPE message_type AS ENUM ('text', 'audio', 'image', 'video', 'file');
CREATE TYPE message_status AS ENUM ('sent', 'delivered', 'read');
CREATE TYPE location_type AS ENUM ('local', 's3', 'minio');

-- Create users table
CREATE TABLE users
(
    id         UUID PRIMARY KEY   DEFAULT gen_random_uuid(),
    email      VARCHAR   NOT NULL UNIQUE,
    username   VARCHAR   NOT NULL UNIQUE,
    password   VARCHAR   NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP
);

-- Create files table
CREATE TABLE files
(
    id            UUID PRIMARY KEY       DEFAULT gen_random_uuid(),
    file_name     VARCHAR       NOT NULL,
    mime_type     VARCHAR       NOT NULL,
    size          INTEGER       NOT NULL,
    location      VARCHAR       NOT NULL,
    location_type location_type NOT NULL,
    created_at    TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at    TIMESTAMP
);

-- Create messages table
CREATE TABLE messages
(
    id               UUID PRIMARY KEY        DEFAULT gen_random_uuid(),
    message          TEXT,
    message_type     message_type   NOT NULL,
    file_id          UUID,
    sender_user_id   UUID           NOT NULL,
    receiver_user_id UUID           NOT NULL,
    status           message_status NOT NULL DEFAULT 'sent',
    created_at       TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at       TIMESTAMP,
    CONSTRAINT fk_sender FOREIGN KEY (sender_user_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT fk_receiver FOREIGN KEY (receiver_user_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT fk_file FOREIGN KEY (file_id) REFERENCES files (id) ON DELETE SET NULL
);

-- Create keys table
CREATE TABLE keys
(
    id                    UUID PRIMARY KEY   DEFAULT gen_random_uuid(),
    public_key            TEXT      NOT NULL,
    encrypted_private_key TEXT      NOT NULL,
    user_id               UUID      NOT NULL UNIQUE,
    created_at            TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at            TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at            TIMESTAMP,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

-- Create indexes on messages table
CREATE INDEX idx_receiver_status_time ON messages (receiver_user_id, status, created_at);
CREATE INDEX idx_sender_time ON messages (sender_user_id, created_at);
CREATE INDEX idx_message_file ON messages (file_id);

-- Create function to automatically update updated_at timestamp
CREATE
OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at
= CURRENT_TIMESTAMP;
RETURN NEW;
END;
$$
language 'plpgsql';

-- Create triggers for updated_at columns
CREATE TRIGGER update_users_updated_at
    BEFORE UPDATE
    ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_messages_updated_at
    BEFORE UPDATE
    ON messages
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_keys_updated_at
    BEFORE UPDATE
    ON keys
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Add comments for documentation
COMMENT
ON TABLE users IS 'Stores user account information';
COMMENT
ON TABLE files IS 'Stores file metadata for messages';
COMMENT
ON TABLE messages IS 'Stores encrypted messages between users';
COMMENT
ON TABLE keys IS 'Stores public and encrypted private keys for users';

COMMENT
ON COLUMN messages.message IS 'Text content only - NULL for file-type messages';
COMMENT
ON COLUMN messages.file_id IS 'Reference to files table for non-text messages';
COMMENT
ON COLUMN keys.encrypted_private_key IS 'Private key encrypted with user passphrase';