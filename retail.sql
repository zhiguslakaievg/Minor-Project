-- Таблица deliveries
CREATE TABLE IF NOT EXISTS public.deliveries
(
    delivery_id serial,
    date_order date NOT NULL,
    delivery_date date NOT NULL,
    cost_of_delivery numeric NOT NULL,
    comment text,
    CONSTRAINT deliveries_pkey PRIMARY KEY (delivery_id)
)

TABLESPACE pg_default;

ALTER TABLE public.deliveries
    OWNER to postgres;

-- Таблица delivery_of_good
CREATE TABLE IF NOT EXISTS public.delivery_of_good
(	del_good_id serial,
    delivery_id serial,
    amount numeric NOT NULL,
    good_id serial,
    unit_price numeric NOT NULL,
    CONSTRAINT delivery_of_good_pkey PRIMARY KEY (del_good_id),
	CONSTRAINT delivery_of_good_fkey1 FOREIGN KEY (good_id)
		 REFERENCES public.goods (good_id) MATCH SIMPLE,
	CONSTRAINT delivery_of_good_fkey2 FOREIGN KEY (delivery_id)
		 REFERENCES public.deliveries (delivery_id) MATCH SIMPLE
)

TABLESPACE pg_default;

ALTER TABLE public.delivery_of_good
    OWNER to postgres;
	
-- Таблица goods
CREATE TABLE IF NOT EXISTS public.goods
(
    good_id serial,
    g_name varchar(50) NOT NULL,
    category_id serial,
	memory varchar(20),
	colour varchar(30) NOT NULL,
	specification text,
    price numeric NOT NULL,
	amount int, 
    CONSTRAINT goods_pkey PRIMARY KEY (good_id),
	CONSTRAINT goods_fkey FOREIGN KEY (category_id)
		 REFERENCES public.category_of_good (category_id) MATCH SIMPLE
)

TABLESPACE pg_default;

ALTER TABLE public.goods
    OWNER to postgres;
	
-- Таблица category_of_good
CREATE TABLE IF NOT EXISTS public.category_of_good
(
    category_id serial,
    category varchar(30) NOT NULL,
	accessories text, 
    CONSTRAINT category_of_good_pkey PRIMARY KEY (category_id)
)

TABLESPACE pg_default;

ALTER TABLE public.category_of_good
    OWNER to postgres;
	
-- Таблица sale
CREATE TABLE IF NOT EXISTS public.discount
(
    sale_id serial,
	good_id serial, 
    discount_size varchar(50) NOT NULL,
    new_price numeric NOT NULL,
	start_date date NOT NULL,
	end_date date NOT NULL,
    CONSTRAINT discount_pkey PRIMARY KEY (sale_id),
	CONSTRAINT discount_fkey FOREIGN KEY (good_id)
		 REFERENCES public.goods (good_id) MATCH SIMPLE
)

TABLESPACE pg_default;

ALTER TABLE public.discount
    OWNER to postgres;
	
-- Таблица staff
CREATE TABLE IF NOT EXISTS public.staff
(
    staff_id serial,
    position_s varchar(30) NOT NULL,
	neces_education varchar(50) NOT NULL,
    wage_rate numeric NOT NULL,
	responsib_s text NOT NULL,
    CONSTRAINT staff_pkey PRIMARY KEY (staff_id)
)

TABLESPACE pg_default;

ALTER TABLE public.staff
    OWNER to postgres;
	
-- Таблица workers
CREATE TABLE IF NOT EXISTS public.workers
(
    worker_id serial, 
    fio varchar(50) NOT NULL,
	birthday date NOT NULL,
	education varchar NOT NULL,
	staff_id serial, 
	salary numeric NOT NULL, 
	email varchar(30),
	phone varchar NOT NULL,
	passport varchar(10) NOT NULL,
	address text,
    CONSTRAINT workers_pkey PRIMARY KEY (worker_id),
	CONSTRAINT workers_fkey FOREIGN KEY (staff_id)
		 REFERENCES public.staff (staff_id) MATCH SIMPLE
)

TABLESPACE pg_default;

ALTER TABLE public.workers
    OWNER to postgres;
	
-- Таблица bonus_for_worker
CREATE TABLE IF NOT EXISTS public.bonus_for_worker
(
    bonus_id serial,
	worker_id serial, 
    payment_date date NOT NULL,
	amount numeric NOT NULL,
    CONSTRAINT bonus_for_worker_pkey PRIMARY KEY (bonus_id),
	CONSTRAINT bonus_for_worker_fkey FOREIGN KEY (worker_id)
		 REFERENCES public.workers (worker_id) MATCH SIMPLE
)

TABLESPACE pg_default;

ALTER TABLE public.bonus_for_worker
    OWNER to postgres;
	
-- Таблица offline_sales
CREATE TABLE IF NOT EXISTS public.offline_sales
(
    receipt_id serial,
	good_id serial, 
	card_id serial, 
	purchase_amount numeric NOT NULL,
	worker_id serial, 
	purchase_date date NOT NULL,
	delivery_type varchar,
    CONSTRAINT offline_sales_pkey PRIMARY KEY (receipt_id),
	CONSTRAINT offline_sales_fkey1 FOREIGN KEY (good_id)
		 REFERENCES public.goods (good_id) MATCH SIMPLE,
	CONSTRAINT offline_sales_fkey2 FOREIGN KEY (card_id)
		 REFERENCES public.loyalty_card_holders (card_id) MATCH SIMPLE,
	CONSTRAINT offline_sales_fkey3 FOREIGN KEY (worker_id)
		 REFERENCES public.workers (worker_id) MATCH SIMPLE
)

TABLESPACE pg_default;

ALTER TABLE public.offline_sales
    OWNER to postgres;
	
-- Таблица loyalty_card_holders
CREATE TABLE IF NOT EXISTS public.loyalty_card_holders
(
    card_id serial,
	person_name varchar(50) NOT NULL, 
	birthday date NOT NULL,
	discount_id serial,
	total_purchases numeric,
    CONSTRAINT loyalty_card_holders_pkey PRIMARY KEY (card_id),
	CONSTRAINT loyalty_card_holders_fkey FOREIGN KEY (discount_id)
		 REFERENCES public.loyalty_card_discounts (discount_id) MATCH SIMPLE
)

TABLESPACE pg_default;

ALTER TABLE public.loyalty_card_holders
    OWNER to postgres;
	
-- Таблица loyalty_card_discounts
CREATE TABLE IF NOT EXISTS public.loyalty_card_discounts
(
    discount_id serial,
	size_purchases numeric,
	discount varchar(20) NOT NULL,
	status varchar(20),
    CONSTRAINT loyalty_card_discounts_pkey PRIMARY KEY (discount_id)
)

TABLESPACE pg_default;

ALTER TABLE public.loyalty_card_discounts
    OWNER to postgres;
	
-- Таблица online_orders
CREATE TABLE IF NOT EXISTS public.online_orders
(
    online_order_id serial,
	good_id serial, 
	card_id serial, 
	order_price numeric NOT NULL,
	worker_id serial,
	type_of_delivery varchar(20) NOT NULL,
	order_date date NOT NULL,
	payment_method varchar(20) NOT NULL,
	customer_comment text,
    CONSTRAINT online_orders_pkey PRIMARY KEY (online_order_id),
	CONSTRAINT online_orders_fkey1 FOREIGN KEY (good_id)
		 REFERENCES public.goods (good_id) MATCH SIMPLE,
	CONSTRAINT online_orders_fkey2 FOREIGN KEY (card_id)
		 REFERENCES public.loyalty_card_holders (card_id) MATCH SIMPLE,
	CONSTRAINT online_orders_fkey3 FOREIGN KEY (worker_id)
		 REFERENCES public.workers (worker_id) MATCH SIMPLE
)

TABLESPACE pg_default;

ALTER TABLE public.online_orders
    OWNER to postgres;
	