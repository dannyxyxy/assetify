-------------------------------------------------
-- Assetify : 사내 비품 관리 시스템 DB 스키마
-- Oracle 11g 기준
-------------------------------------------------

-------------------------------------------------
-- 1. 기존 테이블 / 시퀀스 삭제
-------------------------------------------------
DROP TABLE asset_loans CASCADE CONSTRAINTS PURGE;
DROP TABLE assets CASCADE CONSTRAINTS PURGE;
DROP TABLE asset_category CASCADE CONSTRAINTS PURGE;
DROP TABLE admin_notice CASCADE CONSTRAINTS PURGE;
DROP TABLE users CASCADE CONSTRAINTS PURGE;

DROP SEQUENCE asset_seq;
DROP SEQUENCE loan_seq;
DROP SEQUENCE notice_seq;

-------------------------------------------------
-- 2. 사용자(사원) 테이블
-------------------------------------------------
CREATE TABLE users (
    user_id        VARCHAR2(30) PRIMARY KEY,      -- 로그인 ID
    password       VARCHAR2(100) NOT NULL,         -- 비밀번호
    name           VARCHAR2(50) NOT NULL,          -- 이름
    employee_code  VARCHAR2(20) UNIQUE NOT NULL,  -- 사원증 코드
    role           VARCHAR2(20) DEFAULT 'USER',    -- USER / ADMIN
    status         VARCHAR2(20) DEFAULT 'ACTIVE',  -- ACTIVE / BLOCK
    profile_img    VARCHAR2(300),
    created_at     DATE DEFAULT SYSDATE
);

-------------------------------------------------
-- 3. 비품 카테고리 테이블
-------------------------------------------------
CREATE TABLE asset_category (
    category_id    NUMBER PRIMARY KEY,
    category_name  VARCHAR2(50) NOT NULL
);

-------------------------------------------------
-- 4. 비품 테이블
-------------------------------------------------
CREATE TABLE assets (
    asset_id     NUMBER PRIMARY KEY,
    asset_name   VARCHAR2(100) NOT NULL,
    category_id  NUMBER NOT NULL,
    status       VARCHAR2(20) DEFAULT 'AVAILABLE',
    stock        NUMBER DEFAULT 1,
    description  VARCHAR2(2000),
    created_at   DATE DEFAULT SYSDATE,
    CONSTRAINT fk_asset_category
        FOREIGN KEY (category_id)
        REFERENCES asset_category(category_id)
);

-------------------------------------------------
-- 5. 비품 대여 / 반납 / 승인 테이블
-------------------------------------------------
CREATE TABLE asset_loans (
    loan_id      NUMBER PRIMARY KEY,
    asset_id     NUMBER NOT NULL,
    user_id      VARCHAR2(30) NOT NULL,
    status       VARCHAR2(20) DEFAULT 'PENDING',
    request_date DATE DEFAULT SYSDATE,
    approve_date DATE,
    return_date  DATE,
    admin_id     VARCHAR2(30),
    CONSTRAINT fk_loan_asset FOREIGN KEY (asset_id) REFERENCES assets(asset_id),
    CONSTRAINT fk_loan_user  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-------------------------------------------------
-- 6. 관리자 공지사항 테이블
-------------------------------------------------
CREATE TABLE admin_notice (
    notice_id   NUMBER PRIMARY KEY,
    admin_id    VARCHAR2(30) NOT NULL,
    title       VARCHAR2(200) NOT NULL,
    content     VARCHAR2(2000) NOT NULL,
    created_at  DATE DEFAULT SYSDATE,
    CONSTRAINT fk_notice_admin FOREIGN KEY (admin_id) REFERENCES users(user_id)
);

-------------------------------------------------
-- 7. 시퀀스 생성
-------------------------------------------------
CREATE SEQUENCE asset_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE loan_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE notice_seq START WITH 1 INCREMENT BY 1;

-------------------------------------------------
-- 8. 샘플 데이터
-------------------------------------------------

-- 관리자 / 사용자
INSERT INTO users VALUES ('admin', 'admin', '관리자', 'EMP-0001', 'ADMIN', 'ACTIVE', NULL, SYSDATE);
INSERT INTO users VALUES ('user1', 'user1', '직원1', 'EMP-1001', 'USER', 'ACTIVE', NULL, SYSDATE);

-- 카테고리
INSERT INTO asset_category VALUES (1, 'IT 장비');
INSERT INTO asset_category VALUES (2, '사무용품');
INSERT INTO asset_category VALUES (3, '소모품');

-- 비품
INSERT INTO assets VALUES (asset_seq.NEXTVAL, '노트북', 1, 'AVAILABLE', 5, '업무용 노트북', SYSDATE);
INSERT INTO assets VALUES (asset_seq.NEXTVAL, '마우스', 3, 'AVAILABLE', 20, '무선 마우스', SYSDATE);

-- 공지사항
INSERT INTO admin_notice VALUES (
    notice_seq.NEXTVAL,
    'admin',
    '비품 대여 안내',
    '대여 후 반드시 반납일을 지켜주세요.',
    SYSDATE
);

COMMIT;
