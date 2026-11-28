-- Создание таблиц с ограничениями (в дальнейшем так-же)
CREATE TABLE public.category (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


-- Реализуем логику SERIAL, так как в стандартном PostgreSQL она отсутствует, как тип поля (в дальнейшем так-же)
CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


CREATE TABLE public.manufacturer (
    id integer NOT NULL,
    name character varying(64) NOT NULL
);


CREATE SEQUENCE public.manufacturer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


CREATE TABLE public.orders (
    id integer NOT NULL,
    order_date date NOT NULL,
    delivery_date date NOT NULL,
    fk_pickup_point_id integer NOT NULL,
    fk_user_id integer NOT NULL,
    code integer NOT NULL,
    fk_status_id integer NOT NULL
);


CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


CREATE TABLE public.orders_item (
    fk_order_id integer NOT NULL,
    fk_product_articule character varying(16) NOT NULL,
    count integer NOT NULL
);


CREATE TABLE public.pickup_points (
    id integer NOT NULL,
    adress character varying(256) NOT NULL
);


CREATE SEQUENCE public.pickup_points_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


CREATE TABLE public.products (
    articule character varying(16) NOT NULL,
    name character varying(64) NOT NULL,
    fk_unit_id integer NOT NULL,
    price integer NOT NULL,
    fk_supplyer_id integer NOT NULL,
    fk_manufacturer_id integer NOT NULL,
    fk_category_id integer NOT NULL,
    discount integer NOT NULL,
    count integer NOT NULL,
    description character varying(256) NOT NULL,
    photo character varying
);


CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(256) NOT NULL
);


CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


CREATE TABLE public.status (
    id integer NOT NULL,
    name character varying(32) NOT NULL
);


CREATE SEQUENCE public.status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


CREATE TABLE public.supplyers (
    id integer NOT NULL,
    name character varying(64) NOT NULL
);


CREATE SEQUENCE public.supplyers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


CREATE TABLE public.units (
    id integer NOT NULL,
    name character varying(16) NOT NULL
);


CREATE SEQUENCE public.units_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


CREATE TABLE public.users (
    id integer NOT NULL,
    role_id integer NOT NULL,
    full_name character varying(256) NOT NULL,
    login character varying(320) NOT NULL,
    password character varying(256) NOT NULL
);


CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




-- Вставляем данные в таблицы
INSERT INTO public.category (id, name) VALUES (1, 'Женская обувь');
INSERT INTO public.category (id, name) VALUES (2, 'Мужская обувь');

INSERT INTO public.manufacturer (id, name) VALUES (2, 'CROSBY');
INSERT INTO public.manufacturer (id, name) VALUES (4, 'Marco Tozzi');
INSERT INTO public.manufacturer (id, name) VALUES (5, 'Rieker');
INSERT INTO public.manufacturer (id, name) VALUES (6, 'Рос');
INSERT INTO public.manufacturer (id, name) VALUES (1, 'Kari');
INSERT INTO public.manufacturer (id, name) VALUES (3, 'Alessio Nesca');

INSERT INTO public.orders (id, order_date, delivery_date, fk_pickup_point_id, fk_user_id, code, fk_status_id) VALUES (1, '2025-02-27', '2025-04-20', 1, 4, 901, 1);
INSERT INTO public.orders (id, order_date, delivery_date, fk_pickup_point_id, fk_user_id, code, fk_status_id) VALUES (2, '2022-09-28', '2025-04-21', 11, 1, 902, 1);
INSERT INTO public.orders (id, order_date, delivery_date, fk_pickup_point_id, fk_user_id, code, fk_status_id) VALUES (3, '2025-03-21', '2025-04-22', 2, 2, 903, 1);
INSERT INTO public.orders (id, order_date, delivery_date, fk_pickup_point_id, fk_user_id, code, fk_status_id) VALUES (4, '2025-02-20', '2025-04-23', 11, 3, 904, 1);
INSERT INTO public.orders (id, order_date, delivery_date, fk_pickup_point_id, fk_user_id, code, fk_status_id) VALUES (5, '2025-03-17', '2025-04-24', 2, 4, 905, 1);
INSERT INTO public.orders (id, order_date, delivery_date, fk_pickup_point_id, fk_user_id, code, fk_status_id) VALUES (6, '2025-03-01', '2025-04-25', 15, 1, 906, 1);
INSERT INTO public.orders (id, order_date, delivery_date, fk_pickup_point_id, fk_user_id, code, fk_status_id) VALUES (7, '2025-02-28', '2025-04-26', 3, 2, 907, 1);
INSERT INTO public.orders (id, order_date, delivery_date, fk_pickup_point_id, fk_user_id, code, fk_status_id) VALUES (8, '2025-03-31', '2025-04-27', 19, 3, 908, 2);
INSERT INTO public.orders (id, order_date, delivery_date, fk_pickup_point_id, fk_user_id, code, fk_status_id) VALUES (9, '2025-04-02', '2025-04-28', 5, 4, 909, 2);
INSERT INTO public.orders (id, order_date, delivery_date, fk_pickup_point_id, fk_user_id, code, fk_status_id) VALUES (10, '2025-04-03', '2025-04-29', 19, 4, 910, 2);

INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (1, 'А112Т4', 2);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (2, 'H782T5', 1);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (3, 'J384T6', 10);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (4, 'F572H7', 5);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (5, 'А112Т4', 2);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (6, 'H782T5', 1);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (7, 'J384T6', 10);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (8, 'F572H7', 5);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (9, 'B320R5', 5);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (10, 'S213E3', 5);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (1, 'F635R4', 2);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (2, 'G783F5', 1);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (3, 'D572U8', 10);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (4, 'D329H3', 4);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (5, 'F635R4', 2);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (6, 'G783F5', 1);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (7, 'D572U8', 10);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (8, 'D329H3', 4);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (9, 'G432E4', 1);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (10, 'E482R4', 5);

INSERT INTO public.pickup_points (id, adress) VALUES (1, '420151, г. Лесной, ул. Вишневая, 32');
INSERT INTO public.pickup_points (id, adress) VALUES (2, '125061, г. Лесной, ул. Подгорная, 8');
INSERT INTO public.pickup_points (id, adress) VALUES (3, '630370, г. Лесной, ул. Шоссейная, 24');
INSERT INTO public.pickup_points (id, adress) VALUES (4, '400562, г. Лесной, ул. Зеленая, 32');
INSERT INTO public.pickup_points (id, adress) VALUES (5, '614510, г. Лесной, ул. Маяковского, 47');
INSERT INTO public.pickup_points (id, adress) VALUES (6, '410542, г. Лесной, ул. Светлая, 46');
INSERT INTO public.pickup_points (id, adress) VALUES (7, '620839, г. Лесной, ул. Цветочная, 8');
INSERT INTO public.pickup_points (id, adress) VALUES (8, '443890, г. Лесной, ул. Коммунистическая, 1');
INSERT INTO public.pickup_points (id, adress) VALUES (9, '603379, г. Лесной, ул. Спортивная, 46');
INSERT INTO public.pickup_points (id, adress) VALUES (10, '603721, г. Лесной, ул. Гоголя, 41');
INSERT INTO public.pickup_points (id, adress) VALUES (11, '410172, г. Лесной, ул. Северная, 13');
INSERT INTO public.pickup_points (id, adress) VALUES (12, '614611, г. Лесной, ул. Молодежная, 50');
INSERT INTO public.pickup_points (id, adress) VALUES (13, '454311, г.Лесной, ул. Новая, 19');
INSERT INTO public.pickup_points (id, adress) VALUES (14, '660007, г.Лесной, ул. Октябрьская, 19');
INSERT INTO public.pickup_points (id, adress) VALUES (15, '603036, г. Лесной, ул. Садовая, 4');
INSERT INTO public.pickup_points (id, adress) VALUES (16, '394060, г.Лесной, ул. Фрунзе, 43');
INSERT INTO public.pickup_points (id, adress) VALUES (17, '410661, г. Лесной, ул. Школьная, 50');
INSERT INTO public.pickup_points (id, adress) VALUES (18, '625590, г. Лесной, ул. Коммунистическая, 20');
INSERT INTO public.pickup_points (id, adress) VALUES (19, '625683, г. Лесной, ул. 8 Марта');
INSERT INTO public.pickup_points (id, adress) VALUES (20, '450983, г.Лесной, ул. Комсомольская, 26');
INSERT INTO public.pickup_points (id, adress) VALUES (21, '394782, г. Лесной, ул. Чехова, 3');
INSERT INTO public.pickup_points (id, adress) VALUES (22, '603002, г. Лесной, ул. Дзержинского, 28');
INSERT INTO public.pickup_points (id, adress) VALUES (23, '450558, г. Лесной, ул. Набережная, 30');
INSERT INTO public.pickup_points (id, adress) VALUES (24, '344288, г. Лесной, ул. Чехова, 1');
INSERT INTO public.pickup_points (id, adress) VALUES (25, '614164, г.Лесной,  ул. Степная, 30');
INSERT INTO public.pickup_points (id, adress) VALUES (26, '394242, г. Лесной, ул. Коммунистическая, 43');
INSERT INTO public.pickup_points (id, adress) VALUES (27, '660540, г. Лесной, ул. Солнечная, 25');
INSERT INTO public.pickup_points (id, adress) VALUES (28, '125837, г. Лесной, ул. Шоссейная, 40');
INSERT INTO public.pickup_points (id, adress) VALUES (29, '125703, г. Лесной, ул. Партизанская, 49');
INSERT INTO public.pickup_points (id, adress) VALUES (30, '625283, г. Лесной, ул. Победы, 46');
INSERT INTO public.pickup_points (id, adress) VALUES (31, '614753, г. Лесной, ул. Полевая, 35');
INSERT INTO public.pickup_points (id, adress) VALUES (32, '426030, г. Лесной, ул. Маяковского, 44');
INSERT INTO public.pickup_points (id, adress) VALUES (33, '450375, г. Лесной ул. Клубная, 44');
INSERT INTO public.pickup_points (id, adress) VALUES (34, '625560, г. Лесной, ул. Некрасова, 12');
INSERT INTO public.pickup_points (id, adress) VALUES (35, '630201, г. Лесной, ул. Комсомольская, 17');
INSERT INTO public.pickup_points (id, adress) VALUES (36, '190949, г. Лесной, ул. Мичурина, 26');

INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('А112Т4', 'Ботинки', 1, 4990, 1, 1, 1, 3, 6, 'Женские Ботинки демисезонные kari', '1.jpg');
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('F635R4', 'Ботинки', 1, 3244, 2, 4, 1, 2, 13, 'Ботинки 4 женские демисезонные, размер 39, цвет бежевый', '2.jpg');
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('H782T5', 'Туфли', 1, 4499, 1, 1, 2, 4, 5, 'Туфли kari мужские классика MYZ21AW-450A, размер 43, цвет: черный', '3.jpg');
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('G783F5', 'Ботинки', 1, 5900, 1, 6, 2, 2, 8, 'Мужские ботинки 6-Обувь кожаные с натуральным мехом', '4.jpg');
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('J384T6', 'Ботинки', 1, 3800, 2, 5, 2, 2, 16, 'B3430/14 Полуботинки мужские 5', '5.jpg');
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('D572U8', 'Кроссовки', 1, 4100, 2, 6, 2, 3, 6, '129615-4 Кроссовки мужские', '6.jpg');
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('F572H7', 'Туфли', 1, 2700, 1, 4, 1, 2, 14, 'Туфли 4 женские летние, размер 39, цвет черный', '7.jpg');
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('D329H3', 'Полуботинки', 1, 1890, 2, 3, 1, 4, 4, 'Полуботинки 3 женские 3-30797-47, размер 37, цвет: бордовый', '8.jpg');
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('B320R5', 'Туфли', 1, 4300, 1, 5, 1, 2, 6, 'Туфли 5 женские демисезонные, размер 41, цвет коричневый', '9.jpg');
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('G432E4', 'Туфли', 1, 2800, 1, 1, 1, 3, 15, 'Туфли kari женские TR-YR-413017, размер 37, цвет: черный', '10.jpg');
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('S213E3', 'Полуботинки', 1, 2156, 2, 2, 2, 3, 6, '407700/01-01 Полуботинки мужские 2', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('E482R4', 'Полуботинки', 1, 1800, 1, 1, 1, 2, 14, 'Полуботинки kari женские MYZ20S-149, размер 41, цвет: черный', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('S634B5', 'Кеды', 1, 5500, 2, 2, 2, 3, 0, 'Кеды Caprice мужские демисезонные, размер 42, цвет черный', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('K345R4', 'Полуботинки', 1, 2100, 2, 2, 2, 2, 3, '407700/01-02 Полуботинки мужские 2', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('O754F4', 'Туфли', 1, 5400, 2, 5, 1, 4, 18, 'Туфли женские демисезонные 5 артикул 55073-68/37', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('G531F4', 'Ботинки', 1, 6600, 1, 1, 1, 12, 9, 'Ботинки женские зимние ROMER арт. 893167-01 Черный', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('J542F5', 'Тапочки', 1, 500, 1, 1, 2, 13, 0, 'Тапочки мужские Арт.70701-55-67син р.41', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('B431R5', 'Ботинки', 1, 2700, 2, 5, 2, 2, 5, 'Мужские кожаные ботинки/мужские ботинки', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('P764G4', 'Туфли', 1, 6800, 1, 2, 1, 15, 15, 'Туфли женские, ARGO, размер 38', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('C436G5', 'Ботинки', 1, 10200, 1, 3, 1, 15, 9, 'Ботинки женские, ARGO, размер 40', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('F427R5', 'Ботинки', 1, 11800, 2, 5, 1, 15, 11, 'Ботинки на молнии с декоративной пряжкой FRAU', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('N457T5', 'Полуботинки', 1, 4600, 1, 2, 1, 3, 13, 'Полуботинки Ботинки черные зимние, мех', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('D364R4', 'Туфли', 1, 12400, 1, 1, 1, 16, 5, 'Туфли Luiza Belly женские Kate-lazo черные из натуральной замши', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('S326R5', 'Тапочки', 1, 9900, 2, 2, 2, 17, 15, 'Мужские кожаные тапочки Профиль С.Дали ', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('L754R4', 'Полуботинки', 1, 1700, 1, 1, 1, 2, 7, 'Полуботинки kari женские WB2020SS-26, размер 38, цвет: черный', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('M542T5', 'Кроссовки', 1, 2800, 2, 5, 2, 18, 3, 'Кроссовки мужские TOFA', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('D268G5', 'Туфли', 1, 4399, 2, 5, 1, 3, 12, 'Туфли 5 женские демисезонные, размер 36, цвет коричневый', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('T324F5', 'Сапоги', 1, 4699, 1, 2, 1, 2, 5, 'Сапоги замша Цвет: синий', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('K358H6', 'Тапочки', 1, 599, 1, 5, 2, 20, 2, 'Тапочки мужские син р.41', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('H535R5', 'Ботинки', 1, 2300, 2, 5, 1, 2, 7, 'Женские Ботинки демисезонные', NULL);

INSERT INTO public.roles (id, name) VALUES (1, 'Администратор');
INSERT INTO public.roles (id, name) VALUES (2, 'Менеджер');
INSERT INTO public.roles (id, name) VALUES (3, 'Авторизированный клиент');

INSERT INTO public.status (id, name) VALUES (1, 'Завершен');
INSERT INTO public.status (id, name) VALUES (2, 'Новый ');

INSERT INTO public.supplyers (id, name) VALUES (1, 'Kari');
INSERT INTO public.supplyers (id, name) VALUES (2, 'Обувь для вас');

INSERT INTO public.units (id, name) VALUES (1, 'шт.');

INSERT INTO public.users (id, role_id, full_name, login, password) VALUES (1, 1, 'Никифорова Весения Николаевна', '94d5ous@gmail.com', 'uzWC67');
INSERT INTO public.users (id, role_id, full_name, login, password) VALUES (2, 1, 'Сазонов Руслан Германович', 'uth4iz@mail.com', '2L6KZG');
INSERT INTO public.users (id, role_id, full_name, login, password) VALUES (3, 1, 'Одинцов Серафим Артёмович', 'yzls62@outlook.com', 'JlFRCZ');
INSERT INTO public.users (id, role_id, full_name, login, password) VALUES (4, 2, 'Степанов Михаил Артёмович', '1diph5e@tutanota.com', '8ntwUp');
INSERT INTO public.users (id, role_id, full_name, login, password) VALUES (5, 2, 'Ворсин Петр Евгеньевич', 'tjde7c@yahoo.com', 'YOyhfR');
INSERT INTO public.users (id, role_id, full_name, login, password) VALUES (6, 2, 'Старикова Елена Павловна', 'wpmrc3do@tutanota.com', 'RSbvHv');
INSERT INTO public.users (id, role_id, full_name, login, password) VALUES (7, 3, 'Михайлюк Анна Вячеславовна', '5d4zbu@tutanota.com', 'rwVDh9');
INSERT INTO public.users (id, role_id, full_name, login, password) VALUES (8, 3, 'Ситдикова Елена Анатольевна', 'ptec8ym@yahoo.com', 'LdNyos');
INSERT INTO public.users (id, role_id, full_name, login, password) VALUES (9, 3, 'Ворсин Петр Евгеньевич', '1qz4kw@mail.com', 'gynQMT');
INSERT INTO public.users (id, role_id, full_name, login, password) VALUES (10, 3, 'Старикова Елена Павловна', '4np6se@mail.com', 'AtnDjr');



-- Задаём начальные значения для SERIAL, чтобы он потом не выдавал ошибки при попытке записи в таблицы
SELECT pg_catalog.setval('public.category_id_seq', 2, true);
SELECT pg_catalog.setval('public.manufacturer_id_seq', 6, true);
SELECT pg_catalog.setval('public.orders_id_seq', 10, true);
SELECT pg_catalog.setval('public.pickup_points_id_seq', 36, true);
SELECT pg_catalog.setval('public.roles_id_seq', 3, true);
SELECT pg_catalog.setval('public.status_id_seq', 2, true);
SELECT pg_catalog.setval('public.supplyers_id_seq', 2, true);
SELECT pg_catalog.setval('public.units_id_seq', 1, true);
SELECT pg_catalog.setval('public.users_id_seq', 10, true);


-- Добавляем Primary Key
ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.manufacturer
    ADD CONSTRAINT manufacturer_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.orders_item
    ADD CONSTRAINT orders_item_pkey PRIMARY KEY (fk_order_id, fk_product_articule);


ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.pickup_points
    ADD CONSTRAINT pickup_points_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (articule);


ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.supplyers
    ADD CONSTRAINT supplyers_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.roles
    ADD CONSTRAINT un_roles_name UNIQUE (name);


ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


-- Добавляем Foreign Key
ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_fk_pickup_point_id_fkey FOREIGN KEY (fk_pickup_point_id) REFERENCES public.pickup_points(id);


ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_fk_status_id_fkey FOREIGN KEY (fk_status_id) REFERENCES public.status(id) NOT VALID;


ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_fk_user_id_fkey FOREIGN KEY (fk_user_id) REFERENCES public.users(id);


ALTER TABLE ONLY public.orders_item
    ADD CONSTRAINT orders_item_fk_product_articule_fkey FOREIGN KEY (fk_product_articule) REFERENCES public.products(articule);


ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_fk_category_id_fkey FOREIGN KEY (fk_category_id) REFERENCES public.category(id);


ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_fk_manufacturer_id_fkey FOREIGN KEY (fk_manufacturer_id) REFERENCES public.manufacturer(id);


ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_fk_supplyer_id_fkey FOREIGN KEY (fk_supplyer_id) REFERENCES public.supplyers(id);


ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_fk_unit_id_fkey FOREIGN KEY (fk_unit_id) REFERENCES public.units(id);


ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) NOT VALID;

-- ============================================================
-- ДОПОЛНИТЕЛЬНЫЕ НАСТРОЙКИ ДЛЯ WPF-ПРИЛОЖЕНИЯ
-- ============================================================

-- Дополнительная настройка для исходной базы chudos.sql.
-- Исходные таблицы и данные не переименовываются и не удаляются.
-- Выполнять после импорта chudos.sql в базу exam_v1.

-- Автоматическая выдача ID новым заказам.
ALTER TABLE public.orders
    ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq');

SELECT setval(
    'public.orders_id_seq',
    COALESCE((SELECT MAX(id) FROM public.orders), 0) + 1,
    false
);

-- Отдельная последовательность для кода получения.
CREATE SEQUENCE IF NOT EXISTS public.order_code_seq
    START WITH 1
    INCREMENT BY 1;

SELECT setval(
    'public.order_code_seq',
    COALESCE((SELECT MAX(code) FROM public.orders), 900),
    true
);

-- Связь позиций заказа с заказами. При удалении заказа его позиции удаляются автоматически.
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint
        WHERE conname = 'orders_item_fk_order_id_fkey'
          AND conrelid = 'public.orders_item'::regclass
    ) THEN
        ALTER TABLE public.orders_item
            ADD CONSTRAINT orders_item_fk_order_id_fkey
            FOREIGN KEY (fk_order_id)
            REFERENCES public.orders(id)
            ON DELETE CASCADE;
    END IF;
END
$$;

-- Защита от некорректных значений при последующих изменениях через другие клиенты.
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint
        WHERE conname = 'products_count_nonnegative'
          AND conrelid = 'public.products'::regclass
    ) THEN
        ALTER TABLE public.products
            ADD CONSTRAINT products_count_nonnegative CHECK (count >= 0) NOT VALID;
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint
        WHERE conname = 'products_discount_range'
          AND conrelid = 'public.products'::regclass
    ) THEN
        ALTER TABLE public.products
            ADD CONSTRAINT products_discount_range CHECK (discount BETWEEN 0 AND 100) NOT VALID;
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint
        WHERE conname = 'orders_delivery_date_check'
          AND conrelid = 'public.orders'::regclass
    ) THEN
        ALTER TABLE public.orders
            ADD CONSTRAINT orders_delivery_date_check CHECK (delivery_date >= order_date) NOT VALID;
    END IF;
END
$$;

-- Автоматическая выдача ID новым заказам.
ALTER TABLE public.orders
    ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq');

SELECT setval(
               'public.orders_id_seq',
               COALESCE((SELECT MAX(id) FROM public.orders), 0) + 1,
               false
       );

-- Отдельная последовательность для кода получения.
CREATE SEQUENCE IF NOT EXISTS public.order_code_seq
    START WITH 1
    INCREMENT BY 1;

SELECT setval(
               'public.order_code_seq',
               COALESCE((SELECT MAX(code) FROM public.orders), 900),
               true
       );

-- Связь позиций заказа с заказами. При удалении заказа его позиции удаляются автоматически.
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint
        WHERE conname = 'orders_item_fk_order_id_fkey'
          AND conrelid = 'public.orders_item'::regclass
    ) THEN
ALTER TABLE public.orders_item
    ADD CONSTRAINT orders_item_fk_order_id_fkey
        FOREIGN KEY (fk_order_id)
            REFERENCES public.orders(id)
            ON DELETE CASCADE;
END IF;
END
$$;

-- Защита от некорректных значений при последующих изменениях через другие клиенты.
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint
        WHERE conname = 'products_count_nonnegative'
          AND conrelid = 'public.products'::regclass
    ) THEN
ALTER TABLE public.products
    ADD CONSTRAINT products_count_nonnegative CHECK (count >= 0) NOT VALID;
END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint
        WHERE conname = 'products_discount_range'
          AND conrelid = 'public.products'::regclass
    ) THEN
ALTER TABLE public.products
    ADD CONSTRAINT products_discount_range CHECK (discount BETWEEN 0 AND 100) NOT VALID;
END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint
        WHERE conname = 'orders_delivery_date_check'
          AND conrelid = 'public.orders'::regclass
    ) THEN
ALTER TABLE public.orders
    ADD CONSTRAINT orders_delivery_date_check CHECK (delivery_date >= order_date) NOT VALID;
END IF;
END
$$;
