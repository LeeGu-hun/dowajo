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

create table ds_lecture(
	  lecture_no NUMBER not null primary key,
      lecture_name varchar2(100) not null,
      lecture_description varchar2(2000 BYTE) not null,
      lecture_twitchid varchar2(100),
      regdate date default sysdate
      );
      
insert into ds_lecture (lecture_no, lecture_name, lecture_description, lecture_twitchid) values (1, '테스트강의실1', '테스트강의실설명1', 'childish1986');
insert into ds_lecture (lecture_no, lecture_name, lecture_description, lecture_twitchid) values (2, '테스트강의실2', '테스트강의실설명2', 'kbo2');
insert into ds_lecture (lecture_no, lecture_name, lecture_description, lecture_twitchid) values (3, '테스트강의실3', '테스트강의실설명3', 'lck');
      
CREATE SEQUENCE  "DB7"."DS_LECTURE_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;

create table ds_class_list(
	  lecture_no NUMBER not null,
      user_no varchar2(100) not null,
      class_status varchar2(100) not null,
      regdate date default sysdate,
      constraint fk_ds_class_list foreign key(lecture_no) references ds_lecture(lecture_no) on delete cascade
      );

insert into ds_class_list (lecture_no, user_no, class_status) values (1, 2, 'true');
insert into ds_class_list (lecture_no, user_no, class_status) values (1, 3, 'true');
insert into ds_class_list (lecture_no, user_no, class_status) values (2, 2, 'true');
insert into ds_class_list (lecture_no, user_no, class_status) values (2, 3, 'false');
insert into ds_class_list (lecture_no, user_no, class_status) values (3, 2, 'true');

COMMIT;	 
