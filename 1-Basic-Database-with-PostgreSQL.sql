--create table

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

  --modifying
--insert

insert into "product" ("name", "category", "description", "price", "stock")
values
    ('kopi hitam', 'panas', 'Minuman kopi panas', 15000, 20),
    ('kopi susu', 'panas', 'Minuman kopi panas dengan susu', 18000, 15),
    ('kopi hitam dingin', 'dingin', 'Minuman kopi dingin', 16000, 18),
    ('kopi susu dingin', 'dingin', 'Minuman kopi dingin dengan susu', 19000, 15),
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

--update
   
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

--delete

delete from "product" where "name" in ('susu coklat', 'susu vanilla') and "category" = 'panas';

delete from "promo" where "name" = 'NOVEMBER15';

delete from "user" where "username" = 'fitriani';

delete from "order" where "user_id" = 2;

--upsert

alter table "product" 
add constraint "product_name_unique" unique ("name");

alter table "promo" 
add constraint "promo_name_unique" unique ("name");

alter table "user" 
add constraint "user_username_unique" unique ("username");

insert into "product" ("name", "category", "description", "price", "stock")
values ('kopi hitam', 'panas', 'Minuman kopi panas', 15000, 20)
ON CONFLICT ("name") DO update
set "category" = EXCLUDED."category",
    "description" = EXCLUDED."description",
    "price" = EXCLUDED."price",
    "stock" = EXCLUDED."stock";
   
insert into "promo" ("name", "description", "start_date", "end_date", "discount")
values ('FAZZFOOD10', 'Diskon 10%', '2023-11-01', '2023-11-15', 10.00)
ON CONFLICT ("name") DO update
set "description" = EXCLUDED."description",
    "start_date" = EXCLUDED."start_date",
    "end_date" = EXCLUDED."end_date",
    "discount" = EXCLUDED."discount";

insert into "user" ("username", "password", "full_name", "email")
values ('aldiansyah', 'aldi123', 'Aldiansyah', 'aldiansyah@gmail.com')
ON CONFLICT ("username") DO update
set "password" = EXCLUDED."password",
    "full_name" = EXCLUDED."full_name",
    "email" = EXCLUDED."email";


   --Querying
-- select by name
   
select "product_id", "name", "category", "description", "price", "stock"
from "product"
where "name" = 'kopi hitam';

--column aliases

select "product_id" as "ID", "name" as "Product Name", "price" as "Price"
from "product"
where "name" = 'kopi hitam';

--order by price

select "product_id", "name", "category", "description", "price", "stock"
from "product"
where "category" = 'panas'
order by "price" desc;

--select distinct

select distinct "product_id", "name", "category", "description", "price", "stock"
from "product";


  --Querying by name, category, promo, and price
select
    p."name" as "Product Name",
    p."category" as "Category",
    pr."name" as "Promo Name",
    p."price" as "Price"
from
    "product" p
left join "promo" pr on p."category" = pr."description"
order by
    p."price" asc;
    
alter table "product" rename to "products";
alter table "promo" rename to "promos";
alter table "user" rename to "users";
alter table "order" rename to "orders";

alter table "products" add column "promo_id" int references "promos"("promo_id");
alter table "products" add column "category_id" int references "categories"("category_id");
alter table "promos" add column "product_id" int references "products"("product_id");
alter table "orders" add constraint "fk_orders_user" foreign key ("user_id") references "users"("user_id");


update "orders" set "product_id" = 3, "updated_at" = now() where "product_id" = 6;
alter table "orders" add constraint "fk_orders_product" foreign key ("product_id") references "products"("product_id");

insert into "products" ("name", "category", "description", "price", "stock")
values
    ('kopi tubruk', 'kopi', 'kopi tradisional dengan gula', 12000, 15),
    ('kopi jahe', 'kopi', 'kopi dengan rasa jahe segar', 15000, 12),
    ('es kopi susu', 'susu', 'minuman dingin kopi susu', 18000, 20),
    ('susu coklat dingin', 'susu', 'minuman dingin susu coklat', 14000, 18),
    ('snack kentang', 'snack', 'kentang goreng renyah', 8000, 25),
    ('nugget ayam', 'snack', 'nugget daging ayam', 10000, 22),
    ('kopi tumpeng', 'kopi', 'kopi unik dengan tampilan tumpeng', 25000, 10),
    ('kopi kenangan', 'kopi', 'kopi dengan rasa nostalgia', 16000, 15),
    ('es teh manis', 'susu', 'minuman teh manis dingin', 10000, 20),
    ('kue lapis', 'snack', 'kue lapis tradisional', 7500, 30),
    ('cappuccino', 'kopi', 'kopi dengan busa susu kental', 17000, 18),
    ('es campur', 'susu', 'minuman campur dingin', 12000, 22),
    ('kopi tubruk hitam', 'kopi', 'kopi tubruk tanpa gula', 13000, 12),
    ('susu pisang', 'susu', 'minuman susu pisang segar', 16000, 16),
    ('keripik sayur', 'snack', 'keripik sayuran renyah', 9000, 28),
    ('mie goreng', 'snack', 'mie goreng pedas', 12000, 20),
    ('kopi tawar', 'kopi', 'kopi tawar ringan', 11000, 15),
    ('susu stroberi', 'susu', 'minuman susu stroberi lezat', 17000, 12),
    ('es campur spesial', 'susu', 'es campur dengan berbagai topping', 20000, 10),
    ('kopi vietnam', 'kopi', 'kopi gayo vietnam', 19000, 14),
    ('sate ayam', 'snack', 'sate ayam dengan bumbu kacang', 15000, 18),
    ('kopi tubruk manis', 'kopi', 'kopi tubruk dengan gula', 13000, 16),
    ('susu kacang', 'susu', 'minuman susu kacang gurih', 15000, 20),
    ('kue mangkok', 'snack', 'kue tradisional mangkok', 7000, 25),
    ('teh tarik', 'susu', 'minuman teh tarik klasik', 14000, 20);

update "products" set "category" = 'kopi', "updated_at" = now() where "category" = 'panas';
update "products" set "category" = 'susu', "updated_at" = now() where "category" = 'dingin';

create table "categories" (
    "category_id" serial primary key,
    "name" varchar(50) not null,
    "created_at" timestamp default now(),
    "updated_at" timestamp
);

insert into "categories" ("name")
values
    ('kopi'),
    ('susu'),
    ('snack'),
    ('lainnya');

update "products" p
set "category" = c."category_id", "updated_at" = now()
from "categories" c
where p."category" = c."name";

update "products" p
set "category" = c."category_id"
from "categories" c
where p."category" = c."name";



