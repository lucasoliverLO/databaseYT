create database DatabaseYT;

use DatabaseYT;

create table videos (
id_videos INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
author VARCHAR(30) NOT NULL,
title VARCHAR(30),
likes INT,
dislikes INT
);

insert into videos (author, title, likes, dislikes) values ('Lucas', 'MySQL', '10', '2');
insert into videos (author, title, likes, dislikes) values ('Lucas', 'HTML', '30', '1');
insert into videos (author, title, likes, dislikes) values ('Júlia', 'CSS', '13', '0');
insert into videos (author, title, likes, dislikes) values ('Alice', 'Python', '50', '5');
insert into videos (author, title, likes, dislikes) values ('Alice', 'C++', '35', '1');

select * from videos;

create table author (
id_author INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(30) NOT NULL,
born date
);

insert into author (name, born) values ('Lucas', '1997-01-21');
insert into author (name, born) values ('Júlia', '1997-02-02');
insert into author (name, born) values ('Alice', '2002-03-20');

show tables;
select * from author;

alter table author add phone varchar(14) after born;

update author set phone='21 99163-8971' where id_author=1;
update author set phone='21 99134-4331' where id_author=2;
update author set phone='21 98971-1971' where id_author=3;

select author from videos;

alter table videos drop column author;

select * from videos;

alter table videos add author INT NOT NULL after id_videos;

update videos set author=1 where id_videos=1;
update videos set author=1 where id_videos=2;
update videos set author=1 where id_videos=3;

update videos set author=2 where id_videos=4;

update videos set author=3 where id_videos=5;

alter table videos change author fk_author INT(11) NOT NULL;

alter table videos ADD CONSTRAINT fk_author FOREIGN KEY (fk_author) REFERENCES author(id_author) ON DELETE CASCADE ON UPDATE CASCADE;

describe videos;

select * from videos join author;

select title, name from videos join author on videos.fk_author = author.id_author;

create table seo (
id_seo INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
category VARCHAR(20)
);

select * from seo;
select * from videos;

insert into videos (fk_author, title, likes, dislikes) values (2, 'PHP', 20, 2);

insert into seo (category) values ('Front-end');
insert into seo (category) values ('Back-end');

alter table videos add fk_seo INT NOT NULL after title;

update videos set fk_seo=1 where id_videos=2;
update videos set fk_seo=1 where id_videos=3;

update videos set fk_seo=2 where id_videos=1;
update videos set fk_seo=2 where id_videos=4;
update videos set fk_seo=2 where id_videos=5;
update videos set fk_seo=2 where id_videos=6;

alter table videos add constraint fk_seo foreign key (fk_seo) references seo(id_seo) on delete cascade on update cascade;

select * from videos join seo on videos.fk_seo = seo.id_seo;
select title, name, category from videos join seo on videos.fk_seo = seo.id_seo 
join author on videos.fk_author = author.id_author;

create table playlist (
id_playlist INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
name_playlist VARCHAR(30)
);

insert into playlist(name_playlist) values('HTML + CSS + PHP');
insert into playlist(name_playlist) values('MySQL + C++');
insert into playlist(name_playlist) values('Python + PHP');

select * from playlist;
select * from videos;

create table videos_playlist(
id_vp INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
fk_videos INT,
fk_playlist INT
);

insert into videos_playlist(fk_videos, fk_playlist) values(2,1);
insert into videos_playlist(fk_videos, fk_playlist) values(3,1);
insert into videos_playlist(fk_videos, fk_playlist) values(6,1);

select * from playlist;
select * from videos_playlist;
select * from videos;
select * from author;

select name_playlist, title, name from playlist 
join videos_playlist on playlist.id_playlist = videos_playlist.fk_playlist
join videos on videos.id_videos = videos_playlist.fk_videos
join author on videos.fk_author = author.id_author;

alter table playlist add fk_author INT NOT NULL after id_playlist;

update playlist set fk_author=3 where id_playlist=1;
update playlist set fk_author=3 where id_playlist=2;
update playlist set fk_author=2 where id_playlist=3;

select author.name, playlist.name_playlist from playlist join author on playlist.fk_author = author.id_author;