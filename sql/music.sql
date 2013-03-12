create table musician (
    id serial,
    name varchar(100) not null default '',
    age smallint unsigned null default null,
    band_id bigint unsigned null default null,
    primary key (id)
) engine=Memory;

create table band (
    id serial,
    name varchar(100) not null default '',
    primary key (id)
) engine=Memory;
