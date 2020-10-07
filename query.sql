create table ds_user(
	  user_no NUMBER not null primary key, 
      user_id varchar2(50) not null,
      user_pw varchar2(100) not null,
      user_name varchar2(100) not null,
      user_depart varchar2(100) not null,
      user_mobile varchar2(100),
      user_email varchar2(100),
      regdate date default sysdate
      );

create table ds_auth(
     user_no NUMBER not null,
     user_auth varchar2(100) not null,
     constraint fk_ds_auth foreign key(user_no) references ds_user(user_no)
     );
     
create table persistent_logins (
    username varchar2(64) not null,
    series varchar2(64) primary key,
    token varchar2(64) not null,
    last_used timestamp not null
);

insert into ds_user (user_no, user_id, user_pw, user_name, user_depart) values (1, 'admin', '$2a$10$SbAVSxN4302Gt6vCDtWOa.81ucLL7zzbBhjV7lRh0DEhm7pubjRr.', '관리자', '동성');
insert into ds_user (user_no, user_id, user_pw, user_name, user_depart) values (2, 'teacher', '$2a$10$SbAVSxN4302Gt6vCDtWOa.81ucLL7zzbBhjV7lRh0DEhm7pubjRr.', '강사', '동성');
insert into ds_user (user_no, user_id, user_pw, user_name, user_depart) values (3, 'student', '$2a$10$SbAVSxN4302Gt6vCDtWOa.81ucLL7zzbBhjV7lRh0DEhm7pubjRr.', '학생', '동성');
insert into ds_auth values(1, 'ROLE_ADMIN');
insert into ds_auth values(2, 'ROLE_TEACHER');
insert into ds_auth values(3, 'ROLE_STUDENT');
COMMIT;	  
	  


CREATE SEQUENCE  "DB7"."DS_USER_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;

create table ds_room(
	  room_no NUMBER not null primary key,
      room_name varchar2(100) not null,
      room_description varchar2(2000 BYTE) not null,
      room_videoaddress varchar2(200),
      regdate date default sysdate
      );
      
insert into ds_room (room_no, room_name, room_description, room_videoaddress) values (1, '테스트강의실', '테스트강의실설명', 'https://tv.kakao.com/channel/3673853');
      
CREATE SEQUENCE  "DB7"."DS_ROOM_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
COMMIT;	 
