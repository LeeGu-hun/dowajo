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
     constraint fk_ds_auth foreign key(user_no) references ds_user(user_no) on delete cascade
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
COMMIT

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

/*<추가 10/26> ------------------------------------------------------------------------------------*/
delete from ds_class_list;
alter table ds_class_list modify user_no number;
insert into ds_class_list (lecture_no, user_no, class_status) values (1, 2, 'true');
insert into ds_class_list (lecture_no, user_no, class_status) values (1, 3, 'true');
insert into ds_class_list (lecture_no, user_no, class_status) values (2, 2, 'true');
insert into ds_class_list (lecture_no, user_no, class_status) values (2, 3, 'false');
insert into ds_class_list (lecture_no, user_no, class_status) values (3, 2, 'true');

alter table ds_lecture rename COLUMN lecture_twitchid to lecture_afreecaid;
update ds_lecture set lecture_afreecaid = 'afbaseball1' where lecture_afreecaid='kbo2';
update ds_lecture set lecture_afreecaid = 'AFLOL' where lecture_afreecaid='lck';

commit;
/*</추가 10/26> ------------------------------------------------------------------------------------*/

/*<추가 10/26> ------------------------------------------------------------------------------------*/
CREATE TABLE DS_QA (
    QA_NO NUMBER NOT NULL PRIMARY KEY, 
    QA_WRITER VARCHAR2(20),
    QA_TITLE VARCHAR2(20),
    QA_CONTENT VARCHAR2(200),
    QA_DATE DATE,
    QA_REPLY VARCHAR2(200));
    
CREATE SEQUENCE  "DB7"."DS_QA_SEQ"  MINVALUE 1 MAXVALUE 99999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL;
/*</추가 10/26> ------------------------------------------------------------------------------------*/


/*<추가 10/27> ------------------------------------------------------------------------------------*/


create table ds_file(
	  lecture_no NUMBER not null,
      user_no NUMBER not null,
      file_name varchar2(200) not null,
      regdate date default sysdate,
      constraint fk_ds_file foreign key(lecture_no) references ds_lecture(lecture_no) on delete cascade
      );

alter table ds_lecture add (file_status number(1) default 0 not null constraint booleantest_filestatus_CK check(file_status=0 or file_status=1));

insert into ds_lecture (lecture_no, lecture_name, lecture_description, lecture_afreecaid) values (4, '테스트강의실4', '테스트강의실설명4', 'childish1986');
insert into ds_lecture (lecture_no, lecture_name, lecture_description, lecture_afreecaid) values (5, '테스트강의실5', '테스트강의실설명5', 'afbaseball1');
insert into ds_lecture (lecture_no, lecture_name, lecture_description, lecture_afreecaid) values (6, '테스트강의실6', '테스트강의실설명6', 'AFLOL');
insert into ds_lecture (lecture_no, lecture_name, lecture_description, lecture_afreecaid) values (7, '테스트강의실7', '테스트강의실설명7', 'childish1986');
insert into ds_lecture (lecture_no, lecture_name, lecture_description, lecture_afreecaid) values (8, '테스트강의실8', '테스트강의실설명8', 'afbaseball1');
insert into ds_lecture (lecture_no, lecture_name, lecture_description, lecture_afreecaid) values (9, '테스트강의실9', '테스트강의실설명9', 'AFLOL');
insert into ds_lecture (lecture_no, lecture_name, lecture_description, lecture_afreecaid) values (10, '테스트강의실10', '테스트강의실설명10', 'childish1986');
insert into ds_lecture (lecture_no, lecture_name, lecture_description, lecture_afreecaid) values (11, '테스트강의실11', '테스트강의실설명11', 'afbaseball1');
insert into ds_lecture (lecture_no, lecture_name, lecture_description, lecture_afreecaid) values (12, '테스트강의실12', '테스트강의실설명12', 'AFLOL');
insert into ds_lecture (lecture_no, lecture_name, lecture_description, lecture_afreecaid) values (13, '테스트강의실13', '테스트강의실설명13', 'childish1986');
insert into ds_lecture (lecture_no, lecture_name, lecture_description, lecture_afreecaid) values (14, '테스트강의실14', '테스트강의실설명14', 'afbaseball1');
insert into ds_lecture (lecture_no, lecture_name, lecture_description, lecture_afreecaid) values (15, '테스트강의실15', '테스트강의실설명15', 'AFLOL');

insert into ds_user (user_no, user_id, user_pw, user_name, user_depart) values (4, 'admin2', '$2a$10$SbAVSxN4302Gt6vCDtWOa.81ucLL7zzbBhjV7lRh0DEhm7pubjRr.', '관리자2', '동성');
insert into ds_user (user_no, user_id, user_pw, user_name, user_depart) values (5, 'admin3', '$2a$10$SbAVSxN4302Gt6vCDtWOa.81ucLL7zzbBhjV7lRh0DEhm7pubjRr.', '관리자3', '동성');
insert into ds_user (user_no, user_id, user_pw, user_name, user_depart) values (6, 'teacher2', '$2a$10$SbAVSxN4302Gt6vCDtWOa.81ucLL7zzbBhjV7lRh0DEhm7pubjRr.', '강사2', '동성');
insert into ds_user (user_no, user_id, user_pw, user_name, user_depart) values (7, 'teacher3', '$2a$10$SbAVSxN4302Gt6vCDtWOa.81ucLL7zzbBhjV7lRh0DEhm7pubjRr.', '강사3', '동성');
insert into ds_user (user_no, user_id, user_pw, user_name, user_depart) values (8, 'teacher4', '$2a$10$SbAVSxN4302Gt6vCDtWOa.81ucLL7zzbBhjV7lRh0DEhm7pubjRr.', '강사4', '동성');
insert into ds_user (user_no, user_id, user_pw, user_name, user_depart) values (9, 'student2', '$2a$10$SbAVSxN4302Gt6vCDtWOa.81ucLL7zzbBhjV7lRh0DEhm7pubjRr.', '학생2', '동성');
insert into ds_user (user_no, user_id, user_pw, user_name, user_depart) values (10, 'student3', '$2a$10$SbAVSxN4302Gt6vCDtWOa.81ucLL7zzbBhjV7lRh0DEhm7pubjRr.', '학생3', '동성');
insert into ds_user (user_no, user_id, user_pw, user_name, user_depart) values (11, 'student4', '$2a$10$SbAVSxN4302Gt6vCDtWOa.81ucLL7zzbBhjV7lRh0DEhm7pubjRr.', '학생4', '동성');
insert into ds_user (user_no, user_id, user_pw, user_name, user_depart) values (12, 'student5', '$2a$10$SbAVSxN4302Gt6vCDtWOa.81ucLL7zzbBhjV7lRh0DEhm7pubjRr.', '학생5', '동성');
insert into ds_user (user_no, user_id, user_pw, user_name, user_depart) values (13, 'student6', '$2a$10$SbAVSxN4302Gt6vCDtWOa.81ucLL7zzbBhjV7lRh0DEhm7pubjRr.', '학생6', '동성');
insert into ds_user (user_no, user_id, user_pw, user_name, user_depart) values (14, 'student7', '$2a$10$SbAVSxN4302Gt6vCDtWOa.81ucLL7zzbBhjV7lRh0DEhm7pubjRr.', '학생7', '동성');
insert into ds_user (user_no, user_id, user_pw, user_name, user_depart) values (15, 'student8', '$2a$10$SbAVSxN4302Gt6vCDtWOa.81ucLL7zzbBhjV7lRh0DEhm7pubjRr.', '학생8', '동성');
insert into ds_user (user_no, user_id, user_pw, user_name, user_depart) values (16, 'student9', '$2a$10$SbAVSxN4302Gt6vCDtWOa.81ucLL7zzbBhjV7lRh0DEhm7pubjRr.', '학생9', '동성');
insert into ds_user (user_no, user_id, user_pw, user_name, user_depart) values (17, 'student10', '$2a$10$SbAVSxN4302Gt6vCDtWOa.81ucLL7zzbBhjV7lRh0DEhm7pubjRr.', '학생10', '동성');
insert into ds_user (user_no, user_id, user_pw, user_name, user_depart) values (18, 'student11', '$2a$10$SbAVSxN4302Gt6vCDtWOa.81ucLL7zzbBhjV7lRh0DEhm7pubjRr.', '학생11', '동성');
insert into ds_user (user_no, user_id, user_pw, user_name, user_depart) values (19, 'student12', '$2a$10$SbAVSxN4302Gt6vCDtWOa.81ucLL7zzbBhjV7lRh0DEhm7pubjRr.', '학생12', '동성');

insert into ds_auth values(4, 'ROLE_ADMIN');
insert into ds_auth values(5, 'ROLE_ADMIN');
insert into ds_auth values(6, 'ROLE_TEACHER');
insert into ds_auth values(7, 'ROLE_TEACHER');
insert into ds_auth values(8, 'ROLE_TEACHER');
insert into ds_auth values(9, 'ROLE_STUDENT');
insert into ds_auth values(10, 'ROLE_STUDENT');
insert into ds_auth values(11, 'ROLE_STUDENT');
insert into ds_auth values(12, 'ROLE_STUDENT');
insert into ds_auth values(13, 'ROLE_STUDENT');
insert into ds_auth values(14, 'ROLE_STUDENT');
insert into ds_auth values(15, 'ROLE_STUDENT');
insert into ds_auth values(16, 'ROLE_STUDENT');
insert into ds_auth values(17, 'ROLE_STUDENT');
insert into ds_auth values(18, 'ROLE_STUDENT');
insert into ds_auth values(19, 'ROLE_STUDENT');

insert into ds_class_list (lecture_no, user_no, class_status) values (4, 6, 'true');
insert into ds_class_list (lecture_no, user_no, class_status) values (5, 6, 'true');
insert into ds_class_list (lecture_no, user_no, class_status) values (6, 7, 'true');
insert into ds_class_list (lecture_no, user_no, class_status) values (7, 2, 'true');
insert into ds_class_list (lecture_no, user_no, class_status) values (8, 2, 'true');
insert into ds_class_list (lecture_no, user_no, class_status) values (9, 2, 'true');
insert into ds_class_list (lecture_no, user_no, class_status) values (10, 2, 'true');
insert into ds_class_list (lecture_no, user_no, class_status) values (11, 2, 'true');
insert into ds_class_list (lecture_no, user_no, class_status) values (12, 2, 'true');
insert into ds_class_list (lecture_no, user_no, class_status) values (13, 2, 'true');
insert into ds_class_list (lecture_no, user_no, class_status) values (14, 2, 'true');
insert into ds_class_list (lecture_no, user_no, class_status) values (15, 2, 'true');
insert into ds_class_list (lecture_no, user_no, class_status) values (1, 9, 'true');
insert into ds_class_list (lecture_no, user_no, class_status) values (1, 10, 'true');
insert into ds_class_list (lecture_no, user_no, class_status) values (1, 11, 'false');
insert into ds_class_list (lecture_no, user_no, class_status) values (1, 12, 'false');
insert into ds_class_list (lecture_no, user_no, class_status) values (4, 13, 'true');
insert into ds_class_list (lecture_no, user_no, class_status) values (4, 14, 'true');
insert into ds_class_list (lecture_no, user_no, class_status) values (4, 15, 'false');
insert into ds_class_list (lecture_no, user_no, class_status) values (4, 16, 'false');

insert into ds_class_list (lecture_no, user_no, class_status) values (4, 3, 'true');
insert into ds_class_list (lecture_no, user_no, class_status) values (5, 3, 'true');
insert into ds_class_list (lecture_no, user_no, class_status) values (6, 3, 'true');
insert into ds_class_list (lecture_no, user_no, class_status) values (7, 3, 'true');
insert into ds_class_list (lecture_no, user_no, class_status) values (8, 3, 'true');
insert into ds_class_list (lecture_no, user_no, class_status) values (9, 3, 'false');
insert into ds_class_list (lecture_no, user_no, class_status) values (10, 3, 'false');
insert into ds_class_list (lecture_no, user_no, class_status) values (11, 3, 'false');
insert into ds_class_list (lecture_no, user_no, class_status) values (12, 3, 'false');

commit;

/*<추가 10/27> ------------------------------------------------------------------------------------*/

/*<추가 10/28> ------------------------------------------------------------------------------------*/

alter table ds_file add CONSTRAINT fileName_uq UNIQUE(file_name);
commit;

/*<추가 10/28> ------------------------------------------------------------------------------------*/


/*<추가 10/30> ------------------------------------------------------------------------------------*/
create table ds_attendance(
	  lecture_no NUMBER not null,
      user_no NUMBER not null,
      attendance_state varchar2(200) not null,
      regdate date default sysdate,
      constraint fk_ds_attendance foreign key(lecture_no) references ds_lecture(lecture_no) on delete cascade
);
/*<추가 10/30> ------------------------------------------------------------------------------------*/