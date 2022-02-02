Day 37 -- Database - MySQL


The Following are the tables has to be in your database & model deisgn:

users
codekata
attendance
topics
tasks
company_drives
mentors
students_activated_courses
courses


The following are the queries need to be executed


1. Create tables for the above list given

-- /*courses*/
CREATE TABLE courses(courseid INTEGER AUTO_INCREMENT PRIMARY KEY,coursename VARCHAR(100));

-- /*MENTORS*/
CREATE TABLE mentors(mentorid INTEGER AUTO_INCREMENT PRIMARY KEY,mentorname VARCHAR(100),mentoremail VARCHAR(100));

-- /*Users*/
CREATE TABLE users(userid INTEGER AUTO_INCREMENT PRIMARY KEY, username VARCHAR(100),email VARCHAR(100)
,mentorid INTEGER, 
FOREIGN KEY (mentorid) REFERENCES mentors(mentorid)
);

-- /*codekata*/
CREATE TABLE codekata(codekataid INTEGER AUTO_INCREMENT PRIMARY KEY,userid INTEGER,number_problems INTEGER,
 string_problems INTEGER,
 FOREIGN KEY (userid) REFERENCES users(userid)
 );
 
-- /*topics*/
CREATE TABLE topics(topicsid INTEGER AUTO_INCREMENT PRIMARY KEY,courseid INTEGER, topic VARCHAR(200),
FOREIGN KEY (courseid) REFERENCES courses(courseid)
);

-- /*tasks*/
CREATE TABLE tasks(tasksid INTEGER AUTO_INCREMENT PRIMARY KEY,courseid INTEGER,task VARCHAR(200),
FOREIGN KEY (courseid) REFERENCES courses(courseid)
);

-- /*Attendance*/
CREATE TABLE attendance(attendanceid INTEGER AUTO_INCREMENT PRIMARY KEY, userid INTEGER,courseid INTEGER ,topicsid INTEGER, attended BOOLEAN,
FOREIGN KEY (userid) REFERENCES users(userid),
FOREIGN KEY (topicsid) REFERENCES topics(topicsid),
FOREIGN KEY (courseid) REFERENCES courses(courseid)
);



-- /*Company drives*/
CREATE TABLE company_drives(drivesid INTEGER AUTO_INCREMENT PRIMARY KEY,userid INTEGER,company VARCHAR(100),
FOREIGN KEY (userid) REFERENCES users(userid)
);



-- /*students_activated_courses*/
CREATE TABLE students_activated_courses(id INTEGER AUTO_INCREMENT PRIMARY KEY,userid INTEGER,courseid INTEGER,
FOREIGN KEY (userid) REFERENCES users(userid),
FOREIGN KEY (courseid) REFERENCES courses(courseid)
);


/*2. insert at least 5 rows of values in each table*/


use guvi_task;
-- /*courses*/
INSERT INTO courses VALUES(1,"Javascript");
INSERT INTO courses VALUES(2,"Html");
INSERT INTO courses VALUES(3,"Css");
INSERT INTO courses VALUES(4,"ReactJs");
INSERT INTO courses VALUES(5,"NodeJs");

-- /*mentors*/
INSERT INTO mentors(mentorname,mentoremail) VALUES ("siva","siva@gmail.com");
INSERT INTO mentors(mentorname,mentoremail) VALUES ("kumar","kumar@gmail.com");
INSERT INTO mentors(mentorname,mentoremail) VALUES ("mano","mano@gmail.com");
INSERT INTO mentors(mentorname,mentoremail) VALUES ("muthu","muthu@gmail.com");
INSERT INTO mentors(mentorname,mentoremail) VALUES ("selvi","selvi@gmail.com");

-- /*users*/
INSERT INTO users(username,email,mentorid) VALUES("kesavan","kesavan@gnamil.com",5);
INSERT INTO users(username,email,mentorid) VALUES("saravanan","saravanan@gnamil.com",4);
INSERT INTO users(username,email,mentorid) VALUES("selvan","raj@gnamil.com",4);
INSERT INTO users(username,email,mentorid) VALUES("malathi","malathi@gnamil.com",2);
INSERT INTO users(username,email,mentorid) VALUES("Krishna","krishna@gnamil.com",5);

-- /*codekata*/
INSERT INTO codekata(userid,number_problems,string_problems) VALUES(1,20,10);
INSERT INTO codekata(userid,number_problems,string_problems) VALUES(2,10,20);
INSERT INTO codekata(userid,number_problems,string_problems) VALUES(3,30,40);
INSERT INTO codekata(userid,number_problems,string_problems) VALUES(4,7,30);
INSERT INTO codekata(userid,number_problems,string_problems) VALUES(5,50,50);

-- /*topics*/
INSERT INTO topics(courseid,topic) VALUES(1,"loops and array");
INSERT INTO topics(courseid,topic) VALUES(1,"objects and classes");
INSERT INTO topics(courseid,topic) VALUES(2,"Html basics");
INSERT INTO topics(courseid,topic) VALUES(3,"CSS basics");
INSERT INTO topics(courseid,topic) VALUES(4,"React intro");
INSERT INTO topics(courseid,topic) VALUES(4,"React basics");
INSERT INTO topics(courseid,topic) VALUES(5,"NODE js Router");
INSERT INTO topics(courseid,topic) VALUES(5,"NOde js basics");

-- /*tasks*/
INSERT INTO tasks(courseid,task) VALUES (1,"javascript task");
INSERT INTO tasks(courseid,task) VALUES (2,"Html task");
INSERT INTO tasks(courseid,task) VALUES (3,"Css task");
INSERT INTO tasks(courseid,task) VALUES (4,"ReactJs basics");
INSERT INTO tasks(courseid,task) VALUES (5,"NodeJs task");

-- /*attendence*/
INSERT INTO attendance(userid,courseid,topicsid,attended) VALUES(1,1,1,false);
INSERT INTO attendance(userid,courseid,topicsid,attended) VALUES(1,1,2,false);
INSERT INTO attendance(userid,courseid,topicsid,attended) VALUES(2,2,3,true);
INSERT INTO attendance(userid,courseid,topicsid,attended) VALUES(3,3,4,false);
INSERT INTO attendance(userid,courseid,topicsid,attended) VALUES(4,4,5,true);
INSERT INTO attendance(userid,courseid,topicsid,attended) VALUES(5,5,7,true);

-- /*company drives*/
INSERT INTO company_drives(userid,company) VALUES(1,"SAP labs");
INSERT INTO company_drives(userid,company) VALUES(1,"GIGSA labs");
INSERT INTO company_drives(userid,company) VALUES(1,"Amazon");
INSERT INTO company_drives(userid,company) VALUES(2,"SAP labs");
INSERT INTO company_drives(userid,company) VALUES(3,"Google");
INSERT INTO company_drives(userid,company) VALUES(4,"SAP labs");
INSERT INTO company_drives(userid,company) VALUES(5,"SAP labs");
INSERT INTO company_drives(userid,company) VALUES(5,"Amazon");

/*students activated courses*/
INSERT INTO students_activated_courses(userid,courseid) VALUES(1,1);
INSERT INTO students_activated_courses(userid,courseid) VALUES(1,2);
INSERT INTO students_activated_courses(userid,courseid) VALUES(2,2);
INSERT INTO students_activated_courses(userid,courseid) VALUES(2,3);
INSERT INTO students_activated_courses(userid,courseid) VALUES(3,2);
INSERT INTO students_activated_courses(userid,courseid) VALUES(3,3);
INSERT INTO students_activated_courses(userid,courseid) VALUES(4,4);
INSERT INTO students_activated_courses(userid,courseid) VALUES(5,5);


-- /* Question: 3. get number problems solved in codekata by combining the users*/

Use guvi_task;
SELECT users.userid, users.username,users.email, codekata.number_problems 
FROM users
INNER JOIN codekata ON users.userid = codekata.userid;

--------------------

-- /* Question:4. display the no of company drives attended by a user*/

-- /*for specific user*/

Use guvi_task;
SELECT userid ,count(userid) AS Drives_Attended
FROM company_drives
GROUP BY userid HAVING userid=1;

-- /*for all user*/

use guvi_task;
SELECT userid ,count(userid) AS Drives_Attended
FROM company_drives
GROUP BY userid;

----------------------------------------

-- /* Question:  5. combine and display students_activated_courses and courses for a specific user groping them based on the course*/

use guvi_task;

SELECT students_activated_courses.userid,students_activated_courses.courseid,
COUNT(students_activated_courses.courseid) ,courses.coursename
FROM students_activated_courses
INNER JOIN courses ON students_activated_courses.courseid=courses.courseid
WHERE students_activated_courses.userid=1
GROUP BY courses.courseid;

-------------------------------------------

-- /* Question: 6. list all the mentors*/

USE  guvi_task;
-- /*SELECT * from mentors;*/
SELECT mentorname FROM mentors;

-------------------------------

/* Question: 7. list the number of students that are assigned for a mentor*/

-- /*for specific mentor*/
USE guvi_task;
SELECT mentors.mentorid,mentors.mentorname,COUNT(users.mentorid) AS NUMBER_OF_STUDENTS
FROM mentors,users
WHERE mentors.mentorid=users.mentorid 
GROUP BY mentors.mentorid HAVING mentors.mentorid=4;

-- /*for all mentors*/
USE guvi_task;
SELECT mentors.mentorid,mentors.mentorname,COUNT(users.mentorid) AS NUMBER_OF_STUDENTS
FROM mentors,users
WHERE mentors.mentorid=users.mentorid 
GROUP BY mentors.mentorid;

