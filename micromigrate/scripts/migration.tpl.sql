begin transaction;

create table if not exists micromigrate_migrations (
    id integer primary key,
    name unique,
    checksum,
    completed default 0
);


insert into micromigrate_migrations (name, checksum)
values ("{migration.name}", "{migration.checksum}");

select 'executing' as status;

{migration.sql}
;
select 'finalizing' as stats;

update micromigrate_migrations
set completed = 1
where name = "{migration.name}";

select 'commiting' as status, "{migration.name}" as migration;

commit;
