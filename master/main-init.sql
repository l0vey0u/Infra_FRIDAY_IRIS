SET GLOBAL time_zone='Asia/Seoul';
set time_zone='Asia/Seoul';
create user 'slave_at_mm_sub'@'%' identified by 'Iz0ne!!!!';
create user 'slave_at_ms'@'%' identified by 'Iz0ne!!!!';
grant replication slave on *.* to 'slave_at_mm_sub'@'%' with grant option;
grant replication slave on *.* to 'slave_at_ms'@'%' with grant option;
flush privileges;
CHANGE MASTER TO MASTER_HOST='sub_master_db', MASTER_USER='slave_at_mm_main', MASTER_PASSWORD='Iz0ne!!!!', MASTER_AUTO_POSITION=1;
START SLAVE;
