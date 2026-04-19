CREATE TABLE IF NOT EXISTS ai_chat_session (
                                               id BIGINT PRIMARY KEY AUTO_INCREMENT,
                                               xuehao VARCHAR(64) NOT NULL,
    title VARCHAR(120) NOT NULL DEFAULT 'New Chat',
    is_deleted TINYINT(1) NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_message_at DATETIME NULL,
    INDEX idx_session_xuehao (xuehao),
    INDEX idx_session_last_message (last_message_at)
    );

CREATE TABLE IF NOT EXISTS ai_chat_message (
                                               id BIGINT PRIMARY KEY AUTO_INCREMENT,
                                               session_id BIGINT NOT NULL,
                                               xuehao VARCHAR(64) NOT NULL,
    role VARCHAR(20) NOT NULL,  -- user / assistant / system
    content TEXT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_msg_session (session_id),
    INDEX idx_msg_xuehao (xuehao),
    CONSTRAINT fk_ai_chat_message_session
    FOREIGN KEY (session_id) REFERENCES ai_chat_session(id)
    ON DELETE CASCADE
    );