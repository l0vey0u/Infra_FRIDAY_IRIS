SET GLOBAL time_zone='Asia/Seoul';
set time_zone='Asia/Seoul';
create user 'slave_at_mm_main'@'%' identified by 'Iz0ne!!!!';
grant replication slave on *.* to 'slave_at_mm_main'@'%' with grant option;
CHANGE MASTER TO MASTER_HOST='main_master_db', MASTER_USER='slave_at_mm_sub', MASTER_PASSWORD='Iz0ne!!!!', MASTER_AUTO_POSITION=1;
START SLAVE;
