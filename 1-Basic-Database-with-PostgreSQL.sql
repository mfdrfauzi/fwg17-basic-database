drop table if exists "product";
drop table if exists "promo";
drop table if exists "order";
drop table if exists "user";


create table if not exists "product" (
    "product_id" serial primary key,
    "name" varchar(255) not null,
    "category" varchar(50),
    "description" text,
    "price" decimal(7, 2) not null,
    "stock" int not null,
    "created_at" timestamp default now(),
    "updated_at" timestamp
);

create table if not exists "promo" (
    "promo_id" serial primary key,
    "name" varchar(255) not null,
    "description" text,
    "start_date" date not null,
    "end_date" date not null,
    "discount" decimal(5, 2) not null,
    "created_at" timestamp default now(),
    "updated_at" timestamp
);

create table if not exists "order" (
    "order_id" serial primary key,
    "user_id" int not null,
    "product_id" int not null,
    "quantity" int not null,
    "total_price" decimal(10, 2) not null,
    "order_date" timestamp default now(),
    "updated_at" timestamp
);

create table if not exists "user" (
    "user_id" serial primary key,
    "username" varchar(50) unique not null,
    "password" varchar(255) not null,
    "full_name" varchar(255),
    "email" varchar(100),
    "created_at" timestamp default now(),
    "updated_at" timestamp
);

insert into "product" ("name", "category", "description", "price", "stock")
values
    ('kopi hitam', 'panas', 'Minuman kopi panas', 15000, 20),
    ('kopi susu', 'panas', 'Minuman kopi panas dengan susu', 18000, 15),
    ('iced cappucino', 'dingin', 'Minuman kopi cappucino dingin', 16000, 18),
    ('iced americano', 'dingin', 'Minuman kopi americano', 19000, 15),
    ('susu vanilla', 'panas', 'Minuman susu panas', 12000, 10),
    ('susu coklat', 'panas', 'Minuman susu panas', 12000, 12);

insert into "promo" ("name", "description", "start_date", "end_date", "discount")
values
    ('FAZZFOOD10', 'Diskon 10%', '2023-11-01', '2023-11-15', 10.00),
    ('NOVEMBER15', 'Diskon 15%', '2023-11-10', '2023-11-20', 15.00),
    ('AKHIRTAHUN', 'Diskon 20%', '2023-11-05', '2023-11-15', 20.00),
    ('TIGAEMPAT', 'Diskon 25%', '2023-11-15', '2023-11-30', 25.00);

insert into "order" ("user_id", "product_id", "quantity", "total_price")
values
    (1, 4, 2, 32000),
    (2, 1, 1, 15000),
    (3, 6, 1, 16000);
   
insert into "user" ("username", "password", "full_name", "email")
values
    ('aldiansyah', 'aldi123', 'Aldiansyah', 'aldiansyah@gmail.com.com'),
    ('fitriani', 'fifiyani99', 'Fitriani', 'fifi_fitriani@yahoo.com'),
    ('jokoanwar', 'jokoganteng', 'Joko Anwar', 'joko.ganteng@gmail.com');

update "product" set 
"name" = 'kopi hitam panas', 
"price" = 12000,
"updated_at" = now()
where "name" = 'kopi hitam' and "category" = 'panas';

update "promo" set
"description" = 'Diskon 10% untuk makanan dan minuman' ,
"updated_at" = now()
where "name" = 'FAZZFOOD10';

update "order" set 
"quantity" = 3, 
"total_price" = 45000, 
"updated_at" = now() 
where "user_id" = 1 and "product_id" = 4;

update "user" set 
"full_name" = 'Aldiansyah Taher' ,
"updated_at" = now()
where "username" = 'aldiansyah';

delete from "product" where "name" in ('kopi hitam', 'susu coklat', 'susu vanilla') and "category" = 'panas';

delete from "promo" where "name" = 'NOVEMBER15';

delete from "user" where "username" = 'fitriani';

delete from "order" where "user_id" = 2;

