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
    "p"."name" as "Product Name",
    "p"."category" as "Category",
    "pr"."name" as "Promo Name",
    "p"."price" as "Price"
from
    "product" p
left join "promo" "pr" on "p"."category" = "pr"."description"
order by
    "p"."price" asc;
    
alter table "product" rename to "products";
alter table "promo" rename to "promos";
alter table "user" rename to "users";
alter table "order" rename to "orders";
alter table "products" alter column "price" type numeric(10, 2);
alter table "orders" alter column "total_price" type numeric(10, 2);

update "products" set "category" = 'kopi', "updated_at" = now() where "category" = 'panas';
update "products" set "category" = 'susu', "updated_at" = now() where "category" = 'dingin';

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
   
alter table "products" add column "category_id" int;

alter table "products"
add constraint "products_category_fk"
foreign key ("category_id")
references "categories" ("category_id");

update "products" as "p"
set "category_id" = "c"."category_id"
from "categories" as "c"
where "p"."category" = "c"."name";

alter table "products" drop column "category";

alter table "promos" alter column "discount" type float;
alter table "promos" add column "min_order_price" numeric(10, 2);
alter table "orders" add column "promo_id" int;
alter table "orders" add column "amount_to_pay" numeric(10, 2);
alter table "orders" add constraint "orders_promo_id_fkey" foreign key ("promo_id") references "promos" ("promo_id");

update "promos"
set "min_order_price" = 30000
where "name" = 'FAZZFOOD10';

update "promos"
set "min_order_price" = 50000
where "name" = 'NOVEMBER15';

update "orders" as "o"
set "promo_id" = "p"."promo_id",
    "amount_to_pay" = case
        when "o"."total_price" >= "p"."min_order_price" then "o"."total_price" - ("o"."total_price" * ("p"."discount" / 100))
        else "o"."total_price"
    end
from "promos" as p
where "o"."total_price" >= "p"."min_order_price";

insert into "orders" ("user_id", "product_id", "quantity", "total_price")
values
    (1, 1, 3, 36000),
    (2, 2, 2, 36000),
    (3, 3, 1, 16000),
    (4, 4, 5, 95000),
    (1, 5, 2, 24000),
    (2, 6, 3, 27000);

update "orders"
set "product_id" = 2 , "updated_at" = now()
where "order_id" = 3;

update "orders"
set "product_id" = 12 , "updated_at" = now()
where "order_id" = 8;

   
select "o"."order_id", "o"."user_id", "p"."name" as "productName", "o"."quantity", "o"."total_price", "pr"."name" as "promo_name", "pr"."min_order_price", "o"."amount_to_pay"
from "orders" "o"
left join "products" "p" on "o"."product_id" = "p"."product_id"
left join "promos" "pr" on "o"."promo_id" = "pr"."promo_id";


select "product_id", "name"
from "products"
where "name" like 'kopi%';

select "product_id", "name"
from "products"
where "name" ilike '%sa%';

select "p"."product_id", "p"."name", "c"."name" as "category"
from "products" as "p"
inner join "categories" as "c" on "p"."category_id" = "c"."category_id";

select "p"."product_id", "p"."name", "c"."name" as "category"
from "products" as "p"
left join "categories" as "c" on "p"."category_id" = "c"."category_id";

select "p"."product_id", "p"."name", "c"."name" as "category"
from "products" as "p"
right join "categories" as "c" on "p"."category_id" = "c"."category_id";

select "p"."product_id", "p"."name", "c"."name" as "category"
from "products" as "p"
full outer join "categories" as "c" on "p"."category_id" = "c"."category_id";

begin;
update "products" set "stock" = "stock" - 1 where "product_id" = 1;
insert into "orders" ("user_id", "product_id", "quantity", "total_price") values (1, 1, 1, 15000);
commit;
rollback;

select "user_id", sum("total_price") as "total_order_price"
from "orders"
group by "user_id";

