CREATE SCHEMA education;
CREATE SCHEMA exams;


CREATE TABLE education.groups(
group_id SERIAL PRIMARY KEY,
group_name VARCHAR(255) NOT NULL
);

CREATE TABLE education.students(
student_id SERIAL PRIMARY KEY,
first_name VARCHAR(255) NOT NULL,
last_name VARCHAR(255) NOT NULL,
group_id INT NOT NULL,
FOREIGN KEY (group_id) REFERENCES education.groups (group_id)ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE education.subjects(
subject_id SERIAL PRIMARY KEY,
title_name VARCHAR(255) NOT NULL
);

CREATE TABLE education.teachers(
teacher_id SERIAL PRIMARY KEY,
first_name VARCHAR(255) NOT NULL,
last_name VARCHAR(255) NOT NULL
);

CREATE TABLE education.subjects_teachers(
subject_id INT ,
teacher_id INT ,
group_id INT,
PRIMARY KEY(subject_id,teacher_id,group_id),
FOREIGN KEY (subject_id) REFERENCES education.subjects (subject_id)ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (teacher_id) REFERENCES education.teachers (teacher_id)ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (group_id) REFERENCES education.groups (group_id)ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE exams.marks(
mark_id SERIAL PRIMARY KEY,
student_id INT,
subject_id INT,
date TIMESTAMP,
mark INT,
FOREIGN KEY (subject_id) REFERENCES education.subjects (subject_id)ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (student_id) REFERENCES education.students (student_id)ON DELETE CASCADE ON UPDATE CASCADE

);
