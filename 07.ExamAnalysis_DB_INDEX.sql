## Adem VAROL - 200709078

select * from students;
EXPLAIN select * from students;

select * from exams;
EXPLAIN select * from exams;

explain select * from examsofstudentsdetails;

create unique index idx1 using btree on students(student_id);
create unique index idx2 using btree on exams(exam_id);
create unique index idx3 using btree on examsofstudentsdetails(details_id);

alter table students drop index idx1;


## Adem VAROL - 200709078

select * from proteins;

EXPLAIN select * from proteins where pid like "5HT2C_HUMA%";
EXPLAIN select * from proteins where accession = "Q9UBA6";

create unique index idx1 using btree on proteins(pid);
alter table proteins add constraint acc_pk primary key (accession);

alter table proteins drop index idx1;
alter table proteins drop primary key;

