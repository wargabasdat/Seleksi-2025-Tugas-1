CREATE TABLE public."Order" (
    order_id character varying PRIMARY KEY,
    order_date date,
    cart_id character varying,
    account_email character varying,
    FOREIGN KEY (cart_id) REFERENCES public.cart(cart_id),
    FOREIGN KEY (account_email) REFERENCES public.account(account_email)
);

CREATE TABLE public.account (
    account_email character varying PRIMARY KEY,
    name character varying,
    cart_id character varying
    FOREIGN KEY (cart_id) REFERENCES public.cart(cart_id)
);

CREATE TABLE public.account_address (
    address_id integer PRIMARY KEY,
    account_email character varying,
    street character varying,
    district character varying,
    city character varying,
    province character varying,
    zip_code character varying,
    country character varying,
    FOREIGN KEY (account_email) REFERENCES public.account(account_email)
);

CREATE TABLE public.account_phone (
    account_email character varying,
    phone_number character varying,
    PRIMARY KEY (account_email, phone_number),
    FOREIGN KEY (account_email) REFERENCES public.account(account_email)
);

CREATE TABLE public.cart (
    cart_id character varying PRIMARY KEY,
    quantity integer,
    product_id character varying,
    FOREIGN KEY (product_id) REFERENCES public.products(product_id)
);

CREATE TABLE public.categories (
    category_id character varying PRIMARY KEY,
    name character varying
);

CREATE TABLE public.contains (
    cart_id character varying,
    product_id character varying,
    PRIMARY KEY (cart_id, product_id),
    FOREIGN KEY (cart_id) REFERENCES public.cart(cart_id),
    FOREIGN KEY (product_id) REFERENCES public.products(product_id)
);

CREATE TABLE public.discount_products (
    product_id character varying PRIMARY KEY,
    normal_price numeric,
    FOREIGN KEY (product_id) REFERENCES public.products(product_id)
);

CREATE TABLE public.measurements (
    measurement_id integer PRIMARY KEY,
    product_id character varying,
    size_name character varying,
    details text,
    FOREIGN KEY (product_id) REFERENCES public.products(product_id)
);

CREATE TABLE public.normal_products (
    product_id character varying PRIMARY KEY,
    FOREIGN KEY (product_id) REFERENCES public.products(product_id)
);

CREATE TABLE public.payment (
    payment_id character varying PRIMARY KEY,
    payment_date date,
    payment_method character varying,
    amount numeric,
    order_id character varying,
    FOREIGN KEY (order_id) REFERENCES public."Order"(order_id)
);

CREATE TABLE public.products (
    product_id character varying PRIMARY KEY,
    name character varying,
    description text,
    material text,
    size character varying,
    price numeric,
    image_url text,
    category_id character varying,
    FOREIGN KEY (category_id) REFERENCES public.categories(category_id)
);

CREATE TABLE public.variants (
    variant_id character varying PRIMARY KEY,
    variant_name character varying,
    availability character varying,
    color character varying,
    product_id character varying,
    FOREIGN KEY (product_id) REFERENCES public.products(product_id)
);
