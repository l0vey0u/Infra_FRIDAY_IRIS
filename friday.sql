# 테이블 순서는 관계를 고려하여 한 번에 실행해도 에러가 발생하지 않게 정렬되었습니다.

# date_mealtime_mapping Table Create SQL
CREATE TABLE date_mealtime_mapping
(
    `id`           INT UNSIGNED                                    NOT NULL    AUTO_INCREMENT COMMENT '인덱스', 
    `korean_date`  DATE UNIQUE                             NOT NULL    COMMENT '날짜(20200101)', 
    `meal_time`    ENUM("breakfast", "lunch", "dinner")    NOT NULL    COMMENT '식사시간 ( 1~3 : 아침, 점심, 저녁 )', 
    PRIMARY KEY (id)
);

ALTER TABLE date_mealtime_mapping COMMENT '날짜와 식사시간 데이터를 id 만으로 접근하려는 목적으로 생성... 테이블 이름 맘에 안듬;;';


# date_mealtime_mapping Table Create SQL
CREATE TABLE supply_list
(
    `id`    INT UNSIGNED           NOT NULL    AUTO_INCREMENT COMMENT '인덱스', 
    `name`  VARCHAR(45)    NOT NULL    COMMENT '배식소 이름 [ (군) 급양대 이름 ]', 
    PRIMARY KEY (id)
);

ALTER TABLE supply_list COMMENT '배식소 목록';


# date_mealtime_mapping Table Create SQL
CREATE TABLE group_list
(
    `id`         INT UNSIGNED                  NOT NULL    AUTO_INCREMENT COMMENT '인덱스', 
    `name`       VARCHAR(45) UNIQUE    NOT NULL    COMMENT '집단 이름', 
    `supply_id`  INT UNSIGNED          NULL        COMMENT '배식소 인덱스', 
    PRIMARY KEY (id)
);

ALTER TABLE group_list COMMENT '집단 목록 [ 예 ) 군부대 목록 ]';

ALTER TABLE group_list
    ADD CONSTRAINT FK_group_list_supply_id_supply_list_id FOREIGN KEY (supply_id)
        REFERENCES supply_list (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


# date_mealtime_mapping Table Create SQL
CREATE TABLE group_member_info
(
    `id`         INT UNSIGNED            NOT NULL    AUTO_INCREMENT COMMENT '인덱스', 
    `member_id`  VARCHAR(45)     NOT NULL    COMMENT '구성원 고유 번호 [ 예) 군번 / 순번 ]', 
    `group_id`   INT UNSIGNED    NOT NULL    COMMENT '집단 인덱스', 
    `name`       VARCHAR(15)     NOT NULL    COMMENT '이름', 
    PRIMARY KEY (id)
);

ALTER TABLE group_member_info COMMENT '집단 구성원 정보';

ALTER TABLE group_member_info
    ADD CONSTRAINT FK_group_member_info_group_id_group_list_id FOREIGN KEY (group_id)
        REFERENCES group_list (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


# date_mealtime_mapping Table Create SQL
CREATE TABLE daily_menu
(
    `id`       INT UNSIGNED            NOT NULL    AUTO_INCREMENT COMMENT '인덱스', 
    `date_id`  INT UNSIGNED    NOT NULL    COMMENT '날짜 인덱스', 
    `menu`     VARCHAR(45)     NOT NULL    COMMENT '메뉴', 
    PRIMARY KEY (id)
);

ALTER TABLE daily_menu COMMENT '일일 메뉴 정보';

ALTER TABLE daily_menu
    ADD CONSTRAINT FK_daily_menu_date_id_date_mealtime_mapping_id FOREIGN KEY (date_id)
        REFERENCES date_mealtime_mapping (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


# date_mealtime_mapping Table Create SQL
CREATE TABLE accounts
(
    `member_id`  INT UNSIGNED    NOT NULL    COMMENT '구성원 인덱스', 
    `group_id`   INT UNSIGNED    NOT NULL    COMMENT '집단 인덱스', 
    `password`   CHAR(128)       NOT NULL    COMMENT '비밀 번호 (sha3-512 해싱 )', 
    PRIMARY KEY (member_id)
);

ALTER TABLE accounts COMMENT '회원 가입 정보';

ALTER TABLE accounts
    ADD CONSTRAINT FK_accounts_member_id_group_member_info_id FOREIGN KEY (member_id)
        REFERENCES group_member_info (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE accounts
    ADD CONSTRAINT FK_accounts_group_id_group_list_id FOREIGN KEY (group_id)
        REFERENCES group_list (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


# date_mealtime_mapping Table Create SQL
CREATE TABLE daily_headcount
(
    `date_id`         INT UNSIGNED         NOT NULL    COMMENT '날짜 인덱스', 
    `official_count`  SMALLINT UNSIGNED    NOT NULL    COMMENT '식사 가능 인원 수', 
    `real_count`      SMALLINT UNSIGNED    NULL        COMMENT '실제 식사 인원 수', 
    PRIMARY KEY (date_id)
);

ALTER TABLE daily_headcount COMMENT 'korean_date 관련해서 UTC 관련 설정으로 글로벌하게 쓰일 수 있을 것 같음, 얘는 절대 수정 안할 메인이여야 되네';

ALTER TABLE daily_headcount
    ADD CONSTRAINT FK_daily_headcount_date_id_date_mealtime_mapping_id FOREIGN KEY (date_id)
        REFERENCES date_mealtime_mapping (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


# date_mealtime_mapping Table Create SQL
CREATE TABLE daily_holiday_check
(
    `date_id`              INT UNSIGNED    NOT NULL    COMMENT '날짜 인덱스', 
    `is_weekend`           BIT             NOT NULL    COMMENT '휴일 여부', 
    `before_weekend`       BIT             NOT NULL    COMMENT '휴일 전날 여부', 
    `after_weekend`        BIT             NOT NULL    COMMENT '휴일 다음날 여부', 
    `before_long_weekend`  BIT             NOT NULL    COMMENT '연휴 ( 3일 이상 ) 전날 여부', 
    `after_long_weekend`   BIT             NOT NULL    COMMENT '연휴 ( 3일 이상 ) 다음날 여부', 
    `in_end_year`          BIT             NOT NULL    COMMENT '연말 ( 12 /  21~31 ) 여부', 
    PRIMARY KEY (date_id)
);

ALTER TABLE daily_holiday_check COMMENT '휴일(연휴) 당일 / 전날 / 다음날 여부 정보';

ALTER TABLE daily_holiday_check
    ADD CONSTRAINT FK_daily_holiday_check_date_id_date_mealtime_mapping_id FOREIGN KEY (date_id)
        REFERENCES date_mealtime_mapping (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


# date_mealtime_mapping Table Create SQL
CREATE TABLE daily_weather_jnfo
(
    `date_id`                  INT UNSIGNED                                     NOT NULL    COMMENT '날짜 인덱스', 
    `is_abnormal_temperature`  BIT                                              NOT NULL    COMMENT '이상 기온 여부', 
    `is_heat_wave`             BIT                                              NOT NULL    COMMENT '폭염 여부', 
    `snow`                     BIT                                              NOT NULL    COMMENT '눈 (  진눈깨비 비포함 )', 
    `rain`                     BIT                                              NOT NULL    COMMENT '비 ( 진눈깨비 포함 )', 
    `discomfort_index`         ENUM("low","normal","high","very high")          NOT NULL    COMMENT '불퀘지수', 
    `cloudy`                   ENUM("clear","little cloudy","cloudy","grey")    NOT NULL    COMMENT '흐림 여부', 
    `wind_chill_temperature`   TINYINT UNSIGNED                                 NOT NULL    COMMENT '체감 온도', 
    PRIMARY KEY (date_id)
);

ALTER TABLE daily_weather_jnfo COMMENT '일일 기상 정보';

ALTER TABLE daily_weather_jnfo
    ADD CONSTRAINT FK_daily_weather_jnfo_date_id_date_mealtime_mapping_id FOREIGN KEY (date_id)
        REFERENCES date_mealtime_mapping (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


# date_mealtime_mapping Table Create SQL
CREATE TABLE special_event
(
    `date_id`      INT UNSIGNED    NOT NULL    COMMENT '날짜 인덱스', 
    `is_positive`  BIT             NOT NULL    COMMENT '긍정 이벤트 ( 특식, 복날, 훈련 등 식수 증가 )', 
    `is_negative`  BIT             NOT NULL    COMMENT '부정 이벤트 ( 외부기관 훈련 )', 
    PRIMARY KEY (date_id)
);

ALTER TABLE special_event COMMENT '긍정 / 부정 이벤트 여부';

ALTER TABLE special_event
    ADD CONSTRAINT FK_special_event_date_id_date_mealtime_mapping_id FOREIGN KEY (date_id)
        REFERENCES date_mealtime_mapping (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


# date_mealtime_mapping Table Create SQL
CREATE TABLE menu_info
(
    `menu_id`         INT UNSIGNED    NOT NULL    COMMENT '메뉴 인덱스', 
    `meal_type`       VARCHAR(45)     NOT NULL    COMMENT '메뉴 종류 ( 주식 / 밑 반찬 / 후식 )', 
    `cooking_method`  VARCHAR(45)     NOT NULL    COMMENT '조리 방법 ( 대 분류 )', 
    `ingredient`      VARCHAR(45)     NOT NULL    COMMENT '조리 재료 ( 중분류 )', 
    PRIMARY KEY (menu_id)
);

ALTER TABLE menu_info COMMENT '메뉴 정보 (예시) 가자미 양념 구이 : B_C_EJ ( 밑 반찬 / 구이류 / 어패류, 양념 및 장류 )';

ALTER TABLE menu_info
    ADD CONSTRAINT FK_menu_info_menu_id_daily_menu_id FOREIGN KEY (menu_id)
        REFERENCES daily_menu (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


# date_mealtime_mapping Table Create SQL
CREATE TABLE daily_eat_log
(
    `daily_headcount_id`  INT UNSIGNED    NOT NULL    COMMENT '날짜 인덱스', 
    `member_id`           INT UNSIGNED    NOT NULL    COMMENT '구성원 고유 번호 [ 예) 군번 / 순번 ]', 
    PRIMARY KEY (daily_headcount_id)
);

ALTER TABLE daily_eat_log COMMENT '구성원_실제식사 기록';

ALTER TABLE daily_eat_log
    ADD CONSTRAINT FK_daily_eat_log_member_id_accounts_member_id FOREIGN KEY (member_id)
        REFERENCES accounts (member_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE daily_eat_log
    ADD CONSTRAINT FK_daily_eat_log_daily_headcount_id_date_mealtime_mapping_id FOREIGN KEY (daily_headcount_id)
        REFERENCES date_mealtime_mapping (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


# date_mealtime_mapping Table Create SQL
CREATE TABLE predict_log
(
    `date_id`             INT UNSIGNED         NOT NULL    COMMENT '날짜 인덱스', 
    `predict_real_count`  SMALLINT UNSIGNED    NOT NULL    COMMENT '예측한 실 식수 인원', 
    PRIMARY KEY (date_id)
);

ALTER TABLE predict_log COMMENT '딥러닝 예측 기록';

ALTER TABLE predict_log
    ADD CONSTRAINT FK_predict_log_date_id_date_mealtime_mapping_id FOREIGN KEY (date_id)
        REFERENCES date_mealtime_mapping (id) ON DELETE RESTRICT ON UPDATE RESTRICT;