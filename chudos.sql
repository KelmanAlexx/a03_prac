CREATE TABLE public.category (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.category OWNER TO padmin;


CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.category_id_seq OWNER TO padmin;


CREATE TABLE public.manufacturer (
    id integer NOT NULL,
    name character varying(64) NOT NULL
);


ALTER TABLE public.manufacturer OWNER TO padmin;


CREATE SEQUENCE public.manufacturer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.manufacturer_id_seq OWNER TO padmin;


CREATE SEQUENCE public.order_code_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_code_seq OWNER TO padmin;


CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO padmin;


CREATE TABLE public.orders (
    id integer DEFAULT nextval('public.orders_id_seq'::regclass) NOT NULL,
    order_date date NOT NULL,
    delivery_date date NOT NULL,
    fk_pickup_point_id integer NOT NULL,
    fk_user_id integer NOT NULL,
    code integer NOT NULL,
    fk_status_id integer NOT NULL
);


ALTER TABLE public.orders OWNER TO padmin;


CREATE TABLE public.orders_item (
    fk_order_id integer NOT NULL,
    fk_product_articule character varying(16) NOT NULL,
    count integer NOT NULL
);


ALTER TABLE public.orders_item OWNER TO padmin;


CREATE TABLE public.pickup_points (
    id integer NOT NULL,
    adress character varying(256) NOT NULL
);


ALTER TABLE public.pickup_points OWNER TO padmin;


CREATE SEQUENCE public.pickup_points_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pickup_points_id_seq OWNER TO padmin;


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


ALTER TABLE public.products OWNER TO padmin;


CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(256) NOT NULL
);


ALTER TABLE public.roles OWNER TO padmin;


CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO padmin;


CREATE TABLE public.status (
    id integer NOT NULL,
    name character varying(32) NOT NULL
);


ALTER TABLE public.status OWNER TO padmin;


CREATE SEQUENCE public.status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.status_id_seq OWNER TO padmin;


CREATE TABLE public.supplyers (
    id integer NOT NULL,
    name character varying(64) NOT NULL
);


ALTER TABLE public.supplyers OWNER TO padmin;


CREATE SEQUENCE public.supplyers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.supplyers_id_seq OWNER TO padmin;


CREATE TABLE public.units (
    id integer NOT NULL,
    name character varying(16) NOT NULL
);


ALTER TABLE public.units OWNER TO padmin;


CREATE SEQUENCE public.units_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.units_id_seq OWNER TO padmin;


CREATE TABLE public.users (
    id integer NOT NULL,
    role_id integer NOT NULL,
    full_name character varying(256) NOT NULL,
    login character varying(320) NOT NULL,
    password character varying(256) NOT NULL
);


ALTER TABLE public.users OWNER TO padmin;


CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO padmin;


INSERT INTO public.category (id, name) VALUES (1, 'Мобильные телефоны');
INSERT INTO public.category (id, name) VALUES (2, 'Аудиодевайсы');
INSERT INTO public.category (id, name) VALUES (3, 'Компьютеры');
INSERT INTO public.category (id, name) VALUES (4, 'Смарт-гаджеты');
INSERT INTO public.category (id, name) VALUES (5, 'Компьютерная периферия');
INSERT INTO public.category (id, name) VALUES (6, 'Аксессуары');
INSERT INTO public.category (id, name) VALUES (7, 'Сетевое оборудование');
INSERT INTO public.category (id, name) VALUES (8, 'Компьютерные комплектующие');
INSERT INTO public.category (id, name) VALUES (9, 'Телевизоры и ТВ');
INSERT INTO public.category (id, name) VALUES (10, 'Планшеты');
INSERT INTO public.category (id, name) VALUES (11, 'Игровые консоли');
INSERT INTO public.category (id, name) VALUES (12, 'Мелкая бытовая техника');
INSERT INTO public.category (id, name) VALUES (13, 'Автоэлектроника');
INSERT INTO public.category (id, name) VALUES (14, 'Красота и здоровье');

INSERT INTO public.manufacturer (id, name) VALUES (1, 'Samsung');
INSERT INTO public.manufacturer (id, name) VALUES (2, 'Xiaomi');
INSERT INTO public.manufacturer (id, name) VALUES (3, 'ASUS');
INSERT INTO public.manufacturer (id, name) VALUES (4, 'realme');
INSERT INTO public.manufacturer (id, name) VALUES (5, 'HUAWEI');
INSERT INTO public.manufacturer (id, name) VALUES (6, 'Logitech');
INSERT INTO public.manufacturer (id, name) VALUES (7, 'Baseus');
INSERT INTO public.manufacturer (id, name) VALUES (8, 'MSI');
INSERT INTO public.manufacturer (id, name) VALUES (9, 'JBL');
INSERT INTO public.manufacturer (id, name) VALUES (10, 'TP-Link');
INSERT INTO public.manufacturer (id, name) VALUES (11, 'Kingston');
INSERT INTO public.manufacturer (id, name) VALUES (12, 'TCL');
INSERT INTO public.manufacturer (id, name) VALUES (13, 'WD');
INSERT INTO public.manufacturer (id, name) VALUES (14, 'HONOR');
INSERT INTO public.manufacturer (id, name) VALUES (15, 'Palit');
INSERT INTO public.manufacturer (id, name) VALUES (16, 'Microsoft');
INSERT INTO public.manufacturer (id, name) VALUES (17, 'Fifine');
INSERT INTO public.manufacturer (id, name) VALUES (18, 'Bosch');
INSERT INTO public.manufacturer (id, name) VALUES (19, '70mai');
INSERT INTO public.manufacturer (id, name) VALUES (20, 'Кронштейн');
INSERT INTO public.manufacturer (id, name) VALUES (21, 'Razer');
INSERT INTO public.manufacturer (id, name) VALUES (22, 'Philips');
INSERT INTO public.manufacturer (id, name) VALUES (23, 'Duracell');
INSERT INTO public.manufacturer (id, name) VALUES (24, 'Deerma');

INSERT INTO public.supplyers (id, name) VALUES (1, 'Ситилинк');
INSERT INTO public.supplyers (id, name) VALUES (2, 'Технопарк');

INSERT INTO public.units (id, name) VALUES (1, 'шт.');

INSERT INTO public.roles (id, name) VALUES (1, 'Администратор');
INSERT INTO public.roles (id, name) VALUES (2, 'Менеджер');
INSERT INTO public.roles (id, name) VALUES (3, 'Авторизированный клиент');

INSERT INTO public.status (id, name) VALUES (1, 'Завершен');
INSERT INTO public.status (id, name) VALUES (2, 'Новый');

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
INSERT INTO public.pickup_points (id, adress) VALUES (25, '614164, г.Лесной, ул. Степная, 30');
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

INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('A112T4', 'Смартфон', 1, 49990, 1, 1, 1, 3, 6, 'Смартфон Samsung Galaxy A55 8/256GB, цвет черный', '1.jpg');
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('F635R4', 'Наушники', 1, 3244, 2, 2, 2, 2, 13, 'Беспроводные наушники Xiaomi Redmi Buds 5, цвет белый', '2.jpg');
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('H782T5', 'Ноутбук', 1, 64499, 1, 3, 3, 4, 5, 'Ноутбук ASUS Vivobook 15 X1504ZA-BQ574, Intel Core i3, 8GB, 512GB SSD', '3.jpg');
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('G783F5', 'Смартфон', 1, 15900, 1, 4, 1, 2, 8, 'Смартфон realme C67 8/256GB, цвет зеленый', '4.jpg');
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('J384T6', 'Смарт-часы', 1, 13800, 2, 5, 4, 2, 16, 'Смарт-часы HUAWEI Watch FIT 3, ремешок из фторэластомера, черный', '5.jpg');
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('D572U8', 'Клавиатура', 1, 4100, 2, 6, 5, 3, 6, 'Беспроводная клавиатура Logitech Pebble Keys 2 K380s, графит', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('F572H7', 'Мышь', 1, 2700, 1, 6, 5, 2, 14, 'Беспроводная мышь Logitech M650 L, леворукая, черный', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('D329H3', 'Повербанк', 1, 1890, 2, 7, 6, 4, 4, 'Внешний аккумулятор Baseus Bipow 20W 10000mAh, черный', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('B320R5', 'Монитор', 1, 14300, 1, 8, 3, 2, 6, 'Монитор MSI PRO MP2412 23.8", черный', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('G432E4', 'Колонки', 1, 2800, 1, 9, 2, 3, 15, 'Портативная колонка JBL GO 4, цвет синий', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('S213E3', 'Роутер', 1, 2156, 2, 10, 7, 3, 6, 'Wi-Fi роутер TP-Link Archer C54 AC1200', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('E482R4', 'Накопитель', 1, 1800, 1, 11, 8, 2, 14, 'Флешка Kingston DataTraveler Exodia M 128GB USB 3.2', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('S634B5', 'Телевизор', 1, 35500, 2, 12, 9, 3, 0, 'Телевизор TCL 43P745 43" 4K Ultra HD, черный', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('K345R4', 'Жесткий диск', 1, 5100, 2, 13, 8, 2, 3, 'Внешний жесткий диск WD Elements Portable 1TB', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('O754F4', 'Планшет', 1, 25400, 2, 14, 10, 4, 18, 'Планшет HONOR Pad X9 4/128GB Wi-Fi, серый космос', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('G531F4', 'Видеокарта', 1, 46600, 1, 15, 8, 12, 9, 'Видеокарта Palit NVIDIA GeForce RTX 4060 Dual 8GB', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('J542F5', 'Кабель', 1, 500, 1, 7, 6, 13, 0, 'Кабель Baseus USB Type-C - USB Type-C 100W 1м', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('B431R5', 'Геймпад', 1, 5700, 2, 16, 11, 2, 5, 'Геймпад Microsoft Xbox Wireless Controller, черный', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('P764G4', 'Микрофон', 1, 6800, 1, 17, 2, 15, 15, 'Игровой микрофон Fifine AmpliGame A8 с RGB подсветкой', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('C436G5', 'Электрочайник', 1, 4200, 1, 2, 12, 15, 9, 'Умный электрочайник Xiaomi Smart Kettle Pro, белый', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('F427R5', 'Кофемолка', 1, 3800, 2, 18, 12, 15, 11, 'Электрическая кофемолка Bosch TSM6A013B, черный', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('N457T5', 'Весы', 1, 2600, 1, 2, 4, 3, 13, 'Умные напольные весы Xiaomi Body Composition Scale 2', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('D364R4', 'Видеорегистратор', 1, 8400, 1, 19, 13, 16, 5, 'Видеорегистратор 70mai Dash Cam M300, черный', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('S326R5', 'Кронштейн', 1, 2900, 2, 20, 6, 17, 15, 'Наклонно-поворотный кронштейн для телевизора 32"-55"', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('L754R4', 'Зарядное устр.', 1, 1700, 1, 2, 6, 2, 7, 'Сетевое зарядное устройство Xiaomi Mi 33W Wall Charger', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('M542T5', 'Игровая мышь', 1, 2800, 2, 21, 5, 18, 3, 'Игровая мышь Razer DeathAdder Essential, черный', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('D268G5', 'Эл. бритва', 1, 4399, 2, 22, 14, 3, 12, 'Электробритва Philips Series 1000 S1133/41', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('T324F5', 'Триммер', 1, 3699, 1, 22, 14, 2, 5, 'Триммер для бороды и усов Philips BT3222/14', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('K358H6', 'Батарейки', 1, 599, 1, 23, 6, 20, 2, 'Алкалиновые батарейки Duracell Basic AA, 4 шт.', NULL);
INSERT INTO public.products (articule, name, fk_unit_id, price, fk_supplyer_id, fk_manufacturer_id, fk_category_id, discount, count, description, photo) VALUES ('H535R5', 'Увлажнитель', 1, 2300, 2, 24, 12, 2, 7, 'Увлажнитель воздуха Deerma DEM-F325, белый', NULL);

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

INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (1, 'A112T4', 2);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (1, 'F635R4', 2);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (2, 'H782T5', 1);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (2, 'G783F5', 1);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (3, 'J384T6', 10);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (3, 'D572U8', 10);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (4, 'F572H7', 5);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (4, 'D329H3', 4);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (5, 'A112T4', 2);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (5, 'F635R4', 2);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (6, 'H782T5', 1);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (6, 'G783F5', 1);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (7, 'J384T6', 10);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (7, 'D572U8', 10);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (8, 'F572H7', 5);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (8, 'D329H3', 4);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (9, 'B320R5', 5);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (9, 'G432E4', 1);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (10, 'S213E3', 5);
INSERT INTO public.orders_item (fk_order_id, fk_product_articule, count) VALUES (10, 'E482R4', 5);

SELECT pg_catalog.setval('public.category_id_seq', 14, true);
SELECT pg_catalog.setval('public.manufacturer_id_seq', 24, true);
SELECT pg_catalog.setval('public.order_code_seq', 910, true);
SELECT pg_catalog.setval('public.orders_id_seq', 10, true);
SELECT pg_catalog.setval('public.pickup_points_id_seq', 36, true);
SELECT pg_catalog.setval('public.roles_id_seq', 3, true);
SELECT pg_catalog.setval('public.status_id_seq', 2, true);
SELECT pg_catalog.setval('public.supplyers_id_seq', 2, true);
SELECT pg_catalog.setval('public.units_id_seq', 1, true);
SELECT pg_catalog.setval('public.users_id_seq', 10, true);


ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);



ALTER TABLE ONLY public.manufacturer
    ADD CONSTRAINT manufacturer_pkey PRIMARY KEY (id);



ALTER TABLE public.orders
    ADD CONSTRAINT orders_delivery_date_check CHECK ((delivery_date >= order_date)) NOT VALID;



ALTER TABLE ONLY public.orders_item
    ADD CONSTRAINT orders_item_pkey PRIMARY KEY (fk_order_id, fk_product_articule);



ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);



ALTER TABLE ONLY public.pickup_points
    ADD CONSTRAINT pickup_points_pkey PRIMARY KEY (id);



ALTER TABLE public.products
    ADD CONSTRAINT products_count_nonnegative CHECK ((count >= 0)) NOT VALID;



ALTER TABLE public.products
    ADD CONSTRAINT products_discount_range CHECK (((discount >= 0) AND (discount <= 100))) NOT VALID;



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



ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_fk_pickup_point_id_fkey FOREIGN KEY (fk_pickup_point_id) REFERENCES public.pickup_points(id);



ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_fk_status_id_fkey FOREIGN KEY (fk_status_id) REFERENCES public.status(id) NOT VALID;



ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_fk_user_id_fkey FOREIGN KEY (fk_user_id) REFERENCES public.users(id);



ALTER TABLE ONLY public.orders_item
    ADD CONSTRAINT orders_item_fk_order_id_fkey FOREIGN KEY (fk_order_id) REFERENCES public.orders(id) ON DELETE CASCADE;



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
