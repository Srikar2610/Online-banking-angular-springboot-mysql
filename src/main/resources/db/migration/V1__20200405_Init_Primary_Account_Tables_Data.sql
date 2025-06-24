-- V1__20200405_Init_DB_Schema.sql
-- This script creates the core database schema for the online banking application.

-- Primary Account Table
CREATE TABLE primary_account
(
    id               BIGINT NOT NULL AUTO_INCREMENT,
    account_balance  DECIMAL(19, 2) DEFAULT NULL,
    account_number   VARCHAR(20) NOT NULL UNIQUE, -- Changed to VARCHAR for consistency and potential leading zeros
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Savings Account Table
CREATE TABLE savings_account
(
    id               BIGINT NOT NULL AUTO_INCREMENT,
    account_balance  DECIMAL(19, 2) DEFAULT NULL,
    account_number   VARCHAR(20) NOT NULL UNIQUE, -- Changed to VARCHAR for consistency and potential leading zeros
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- User Table (Moved from V3 and improved)
CREATE TABLE user
(
    user_id              BIGINT NOT NULL AUTO_INCREMENT,
    email                VARCHAR(255) NOT NULL UNIQUE,
    enabled              BOOLEAN NOT NULL, -- Changed from BIT(1) to BOOLEAN for better compatibility
    first_name           VARCHAR(255) DEFAULT NULL,
    last_name            VARCHAR(255) DEFAULT NULL,
    password             VARCHAR(255) DEFAULT NULL,
    phone                VARCHAR(255) DEFAULT NULL,
    username             VARCHAR(255) DEFAULT NULL,
    primary_account_id   BIGINT DEFAULT NULL,
    savings_account_id   BIGINT DEFAULT NULL,
    PRIMARY KEY (user_id),
    UNIQUE KEY UK_user_email (email), -- Explicit unique key name
    UNIQUE KEY UK_user_username (username), -- Assuming username should also be unique
    CONSTRAINT FK_user_primary_account FOREIGN KEY (primary_account_id) REFERENCES primary_account (id),
    CONSTRAINT FK_user_savings_account FOREIGN KEY (savings_account_id) REFERENCES savings_account (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Role Table
CREATE TABLE role
(
    role_id BIGINT NOT NULL AUTO_INCREMENT,
    name    VARCHAR(255) NOT NULL UNIQUE,
    PRIMARY KEY (role_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- User_Role Join Table
CREATE TABLE user_role
(
    user_id BIGINT NOT NULL,
    role_id BIGINT NOT NULL,
    PRIMARY KEY (user_id, role_id),
    CONSTRAINT FK_user_role_user FOREIGN KEY (user_id) REFERENCES user (user_id) ON DELETE CASCADE,
    CONSTRAINT FK_user_role_role FOREIGN KEY (role_id) REFERENCES role (role_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Primary Transaction Table
CREATE TABLE primary_transaction
(
    id                BIGINT NOT NULL AUTO_INCREMENT,
    date              DATETIME NOT NULL,
    description       VARCHAR(255),
    type              VARCHAR(50),
    status            VARCHAR(50),
    amount            DECIMAL(19, 2) NOT NULL,
    available_balance DECIMAL(19, 2) NOT NULL,
    primary_account_id BIGINT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_primary_transaction_account FOREIGN KEY (primary_account_id) REFERENCES primary_account (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Savings Transaction Table
CREATE TABLE savings_transaction
(
    id                BIGINT NOT NULL AUTO_INCREMENT,
    date              DATETIME NOT NULL,
    description       VARCHAR(255),
    type              VARCHAR(50),
    status            VARCHAR(50),
    amount            DECIMAL(19, 2) NOT NULL,
    available_balance DECIMAL(19, 2) NOT NULL,
    savings_account_id BIGINT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_savings_transaction_account FOREIGN KEY (savings_account_id) REFERENCES savings_account (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Recipient Table
CREATE TABLE recipient
(
    id             BIGINT NOT NULL AUTO_INCREMENT,
    name           VARCHAR(255) NOT NULL,
    email          VARCHAR(255),
    phone          VARCHAR(20),
    account_number VARCHAR(20) NOT NULL,
    description    VARCHAR(255),
    user_id        BIGINT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_recipient_user FOREIGN KEY (user_id) REFERENCES user (user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Appointment Table
CREATE TABLE appointment
(
    id          BIGINT NOT NULL AUTO_INCREMENT,
    date        DATETIME NOT NULL,
    location    VARCHAR(255),
    description VARCHAR(255),
    confirmed   BOOLEAN DEFAULT FALSE,
    user_id     BIGINT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_appointment_user FOREIGN KEY (user_id) REFERENCES user (user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Audit Table (Moved from V2 to V1 for consolidation as it's a core schema element)
CREATE TABLE audit_log
(
    id         BIGINT NOT NULL AUTO_INCREMENT,
    entity_id  BIGINT,
    entity_type VARCHAR(255),
    action     VARCHAR(255),
    timestamp  DATETIME,
    user_id    BIGINT,
    details    TEXT,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
