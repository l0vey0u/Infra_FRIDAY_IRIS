SET GLOBAL time_zone='Asia/Seoul';
set time_zone='Asia/Seoul';
CHANGE MASTER TO MASTER_HOST='main_master_db', MASTER_USER='slave_at_ms', MASTER_PASSWORD='Iz0ne!!!!', MASTER_AUTO_POSITION=1;
START SLAVE;
