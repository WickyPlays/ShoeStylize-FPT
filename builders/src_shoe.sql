CREATE TABLE "Role"
(
    id       VARCHAR(40) PRIMARY KEY,
    "name"   VARCHAR(40),
    priority INT DEFAULT 0
);

CREATE TABLE "User_Login_Method"
(
    login_method VARCHAR(20) PRIMARY KEY
);

CREATE TABLE "User"
(
    id             SERIAL PRIMARY KEY,
    username       VARCHAR(40)         NOT NULL,
    firstname      VARCHAR(40),
    lastname       VARCHAR(40),
    email          VARCHAR(320) UNIQUE NOT NULL,
    "password"     VARCHAR(40)         NOT NULL,
    "address"      VARCHAR(320),
    date_birth     DATE                NOT NULL,
    contact_number VARCHAR(11),
    city           VARCHAR(320),
    "state"        VARCHAR(320),
    role_id        VARCHAR(40)         NOT NULL,
    login_method   VARCHAR(20)         NOT NULL DEFAULT 'normal',
    token          VARCHAR(50)         NOT NULL,
    FOREIGN KEY (role_id) REFERENCES "Role" (id),
    FOREIGN KEY (login_method) REFERENCES "User_Login_Method" (login_method)
);

CREATE TABLE "News"
(
    id           SERIAL PRIMARY KEY,
    title        VARCHAR(255) NOT NULL,
    content      TEXT         NOT NULL,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    author_id    INT          NOT NULL,
    FOREIGN KEY (author_id) REFERENCES "User" (id)
);

CREATE TABLE "Shoe_Type"
(
    id VARCHAR(20) PRIMARY KEY
);

CREATE TABLE "Shoe_Gallery"
(
    id         SERIAL PRIMARY KEY,
    shoe_id    INT  NOT NULL,
    image_link TEXT NOT NULL
);

CREATE TABLE "Shoe_Size"
(
    id        SERIAL PRIMARY KEY,
    size_name VARCHAR(10) NOT NULL,
    "type_id" VARCHAR(20) NOT NULL,
    gender    VARCHAR(1)  NOT NULL,
    FOREIGN KEY ("type_id") REFERENCES "Shoe_Type" (id)
);

CREATE TABLE "Shoe"
(
    id            SERIAL PRIMARY KEY,
    title         VARCHAR(750) NOT NULL,
    image_link    TEXT,
    date_created  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "description" TEXT,
    price         FLOAT        NOT NULL,
    shoe_type     VARCHAR(20)  NOT NULL,
    FOREIGN KEY (shoe_type) REFERENCES "Shoe_Type" (id)
);

CREATE TABLE "Bill"
(
    id           SERIAL PRIMARY KEY,
    author_id    INT NOT NULL,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES "User" (id)
);

CREATE TABLE "Order_Shoe_Status"
(
    id VARCHAR(20) PRIMARY KEY
);

CREATE TABLE "Order_Payment_Method"
(
    id VARCHAR(20) PRIMARY KEY
);

DROP TABLE "Order_Shoe_Extra";
DROP TABLE "Order_Shoe";

CREATE TABLE "Order_Shoe"
(
    id                    SERIAL PRIMARY KEY,
    shoe_id               INT          NOT NULL,
    image_link            BYTEA,
    date_created          TIMESTAMP             DEFAULT CURRENT_TIMESTAMP,
    bill_id               INT          NOT NULL,
    first_name            VARCHAR(25),
    last_name             VARCHAR(25),
    email                 VARCHAR(320),
    "address1"            VARCHAR(500),
    "address2"            VARCHAR(500),
    phone1                VARCHAR(11),
    phone2                VARCHAR(11),
    size_id               INT          NOT NULL,
    customer_note         VARCHAR(750) NOT NULL,
    reference_note        VARCHAR(750),
    texture_data          TEXT,
    total_price           FLOAT        NOT NULL DEFAULT 0,
    order_shoe_status     VARCHAR(20)           DEFAULT 'pending',
    order_paid            BOOLEAN               DEFAULT FALSE,
    order_payment_method  VARCHAR(20),
    service_provider_id   INT,
    service_provider_note VARCHAR(750),
    FOREIGN KEY (shoe_id) REFERENCES "Shoe" (id),
    FOREIGN KEY (bill_id) REFERENCES "Bill" (id),
    FOREIGN KEY (size_id) REFERENCES "Shoe_Size" (id),
    FOREIGN KEY (order_shoe_status) REFERENCES "Order_Shoe_Status" (id),
    FOREIGN KEY (order_payment_method) REFERENCES "Order_Payment_Method" (id),
    FOREIGN KEY (service_provider_id) REFERENCES "User" (id)
);

CREATE TABLE "Shoe_Extra_Type"
(
    id VARCHAR(32) PRIMARY KEY
);

CREATE TABLE "Shoe_Extra"
(
    id            SERIAL PRIMARY KEY,
    title         VARCHAR(750) NOT NULL,
    image_link    TEXT,
    date_created  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "description" VARCHAR(750),
    price         FLOAT        NOT NULL,
    "type"        VARCHAR(32)  NOT NULL,
    FOREIGN KEY ("type") REFERENCES "Shoe_Extra_Type" (id)
);

CREATE TABLE "Order_Shoe_Extra"
(
    id            SERIAL PRIMARY KEY,
    shoe_extra_id INT NOT NULL,
    order_shoe_id INT NOT NULL,
    date_created  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (shoe_extra_id) REFERENCES "Shoe_Extra" (id),
    FOREIGN KEY (order_shoe_id) REFERENCES "Order_Shoe" (id)
);

INSERT INTO "User_Login_Method"
VALUES ('normal'),
       ('google');
INSERT INTO "Shoe_Type"
VALUES ('low-tops'),
       ('high-tops'),
       ('boots'),
       ('others');
INSERT INTO "Shoe_Extra_Type"
VALUES ('accessory');
INSERT INTO "Order_Payment_Method"
VALUES ('cod'),
       ('momo');

INSERT INTO "Order_Shoe_Status"
VALUES ('pending'),
       ('cancelled'),
       ('reverify'),
       ('in_progress'),
       ('success');

-- Insert into "Role" table
INSERT INTO "Role" VALUES ('customer', 'Customer', 0), ('service_provider', 'Service Provider', 1), ('admin', 'Admin', 2);

DELETE FROM "User";

-- Insert into "User" table
INSERT INTO "User" (username, firstname, lastname, email, password, address, date_birth, contact_number, city, state, role_id, token)
VALUES ('thienbao860', 'Từ Thiên', 'Bảo', 'nguyenthienbao860@gmail.com', '12345', '123 Đường X, Quận Y, TP.HCM', '2003-04-15', '09012345678', 'Ho Chi Minh City', 'Ho Chi Minh', 'admin', 'R3sPvNq2XmH9zWp6Q8LcKlDv7O1eJnY5fT0iAaGyUgSbZw4oF');

INSERT INTO "User" (username, firstname, lastname, email, password, address, date_birth, contact_number, city, state, role_id, token)
VALUES ('phamvantrieuthuan', 'Phạm', 'Thuận', 'phamthuan95@gmail.com', '12345', '789 Đường C, Quận 3, TP.HCM', '1995-07-10', '07654321098', 'Ho Chi Minh City', 'Ho Chi Minh', 'admin', 'R3sPvNq2XmH9zWp6Q8LcKlDv7O1eJnY5fT0iAaGyUgSbZw4oG');

INSERT INTO "User" (username, firstname, lastname, email, password, address, date_birth, contact_number, city, state, role_id, token)
VALUES ('baongoc', 'Ngoc', 'Bui', 'buibaongoc@gmail.com', '12345', '83 PhuocLongB, Quận 9, TP.HCM', '2003-09-21', '0989301427', 'Ho Chi Minh City', 'Ho Chi Minh', 'customer', 'R3sPvNq2XmH9zWp6Q8LcKlDv7O1eJnY5fT0iAaGyUgSbZw4oH');

INSERT INTO "User" (username, firstname, lastname, email, password, address, date_birth, contact_number, city, state, role_id, token)
VALUES ('buivantuanlam1410', 'Tuấn', 'Lâm', 'tuanlam1410@gmail.com', '12345', '250 Man Thiện, TP.HCM', '1995-10-14', '0367797348', 'Ho Chi Minh City', 'Ho Chi Minh', 'customer', 'R3sPvNq2XmH9zWp6Q8LcKlDv7O1eJnY5fT0iAaGyUgSbZw4oI');

INSERT INTO "User" (username, firstname, lastname, email, password, address, date_birth, contact_number, city, state, role_id, token)
VALUES ('phamtanty789', 'Tan', 'Ty', 'phamtanty789@gmail.com', '123456789', '79/5A Đường C, Quận 12, TP.HCM', '1995-07-10', '07654321098', 'Ho Chi Minh City', 'Ho Chi Minh', 'customer', 'R3sPvNq2XmH9zWp6Q8LcKlDv7O1eJnY5fT0iAaGyUgSbZw4oJ');


-- Delete from "Shoe" table and reset identity
DELETE FROM "Shoe";
ALTER SEQUENCE "Shoe_id_seq" RESTART WITH 1;

INSERT INTO "Shoe" (title, description, price, shoe_type)
VALUES
    ('Urban Elegance: High-Top Sneakers', '%3Cp%3E-%20Embrace%20style%20and%20sustainability%20with%20100%25%20vegan%20leather,%20seamlessly%20blending%20fashion%20with%20eco-friendly%20principles.%3C/p%3E%0A%3Cp%3E-%20Elevate%20your%20urban%20look%20with%20a%20rubber%20outsole%20and%20EVA%20insole,%20ensuring%20both%20comfort%20and%20a%20guilt-free%20stride.%3C/p%3E%0A%3Cp%3E-%20Stay%20light%20and%20stylish%20with%20a%20mesh%20and%20foamed%20lining,%20effortlessly%20combining%20sophistication%20with%20breathability.%3C/p%3E%0A%3Cp%3E-%20Conquer%20the%20city%20in%20confidence%20with%20waterproof,%20anti-heat,%20and%20anti-moisture%20features%20&ndash;%20a%20stylish%20shield%20against%20the%20elements.%3C/p%3E%0A%3Cp%3E-%20Achieve%20a%20perfect%20fit%20and%20instant%20style%20elevation%20with%20a%20lace-up%20closure,%20embodying%20fashion-forward%20choices%20in%20every%20step.%3C/p%3E', 59.99, 'high-tops'),
    ('Retro Cool: Vintage High-Tops', '%3Cp%3E-%20Step%20into%20vintage%20coolness%20with%20high-tops%20boasting%20eco-friendly,%20100%25%20vegan%20leather%20&ndash;%20a%20stylish%20nod%20to%20the%20past%20with%20a%20sustainable%20stride.%3C/p%3E%0A%3Cp%3E-%20Merge%20timeless%20aesthetics%20with%20contemporary%20comfort%20in%20these%20vintage%20high-tops,%20marrying%20classic%20design%20with%20eco-conscious%20materials.%3C/p%3E%0A%3Cp%3E-%20Elevate%20your%20style%20with%20a%20blend%20of%20classic%20charm%20and%20sustainable%20fashion,%20as%20these%20high-tops%20redefine%20retro%20coolness%20with%20eco-friendly%20flair.%3C/p%3E%0A%3Cp%3E-%20Brave%20any%20forecast%20in%20fashion-forward%20vintage%20high-tops,%20featuring%20waterproof,%20anti-heat,%20and%20anti-moisture%20attributes%20for%20a%20blend%20of%20style%20and%20practicality.%3C/p%3E%0A%3Cp%3E-%20Perfect%20your%20retro%20look%20effortlessly%20with%20a%20lace-up%20closure,%20combining%20the%20timeless%20appeal%20of%20vintage%20high-tops%20with%20an%20ethical%20touch%20through%20eco-friendly%20elements.%3C/p%3E', 64.99, 'high-tops');

INSERT INTO "Shoe" (title, description, price, shoe_type)
VALUES
    ('Sleek Minimalism: White Canvas Low-Tops', '%3Cp%3E-%20Embrace%20minimalist%20chic%20with%20white%20canvas%20low-tops,%20offering%20a%20sleek%20aesthetic%20that%20effortlessly%20marries%20simplicity%20with%20understated%20luxury.%3C/p%3E%0A%3Cp%3E-%20Step%20into%20the%20epitome%20of%20minimalist%20style%20with%20canvas%20low-tops%20that%20blend%20ease%20and%20comfort,%20redefining%20casual%20sophistication%20with%20each%20stride.%3C/p%3E%0A%3Cp%3E-%20Elevate%20your%20daily%20look%20with%20the%20timeless%20appeal%20of%20white%20canvas%20low-tops,%20embodying%20simplicity%20as%20the%20ultimate%20form%20of%20refinement.%3C/p%3E%0A%3Cp%3E-%20Conquer%20style%20with%20ease%20in%20white%20canvas%20low-tops%20that%20transcend%20seasons,%20providing%20a%20versatile%20and%20minimalist%20footwear%20choice%20for%20any%20occasion.%3C/p%3E%0A%3Cp%3E-%20Perfect%20your%20ensemble%20with%20a%20lace-up%20closure,%20epitomizing%20sleek%20minimalism%20and%20adding%20an%20element%20of%20effortless%20chic%20to%20your%20white%20canvas%20low-top%20style.%3C/p%3E', 49.99, 'low-tops'),
    ('Casual Elegance: Navy Blue Low-Tops', '%3Cp%3E-%20Embrace%20casual%20elegance%20with%20navy%20blue%20low-tops,%20effortlessly%20blending%20a%20laid-back%20vibe%20with%20a%20touch%20of%20refined%20sophistication.%3C/p%3E%0A%3Cp%3E-%20Step%20into%20the%20epitome%20of%20casual%20elegance%20with%20navy%20blue%20low-tops%20that%20harmonize%20comfort%20and%20style,%20redefining%20everyday%20sophistication.%3C/p%3E%0A%3Cp%3E-%20Elevate%20your%20daily%20look%20with%20the%20classic%20allure%20of%20navy%20blue%20low-tops,%20embodying%20a%20casual%20elegance%20that%20effortlessly%20exudes%20refinement.%3C/p%3E%0A%3Cp%3E-%20Conquer%20style%20with%20ease%20in%20navy%20blue%20low-tops%20that%20offer%20a%20versatile%20and%20casually%20elegant%20footwear%20choice,%20suitable%20for%20any%20occasion.%3C/p%3E%0A%3Cp%3E-%20Perfect%20your%20ensemble%20with%20a%20lace-up%20closure,%20epitomizing%20casual%20elegance%20and%20adding%20an%20element%20of%20effortless%20sophistication%20to%20your%20navy%20blue%20low-top%20style.%3C/p%3E', 54.99, 'low-tops');

INSERT INTO "Shoe" (title, description, price, shoe_type)
VALUES
    ('Versatile Charm: Brown Leather Boots', '%3Cp%3E-%20Embrace%20versatile%20charm%20with%20brown%20leather%20boots,%20embodying%20a%20timeless%20elegance%20that%20effortlessly%20transitions%20from%20casual%20to%20refined.%3C/p%3E%0A%3Cp%3E-%20Step%20into%20the%20epitome%20of%20versatility%20with%20brown%20leather%20boots%20that%20seamlessly%20blend%20enduring%20style%20with%20comfort,%20from%20day%20to%20night.%3C/p%3E%0A%3Cp%3E-%20Elevate%20your%20look%20with%20the%20classic%20charm%20of%20brown%20leather%20boots,%20embodying%20a%20versatile%20charm%20that%20effortlessly%20exudes%20sophistication.%3C/p%3E%0A%3Cp%3E-%20Conquer%20style%20with%20adaptability%20in%20brown%20leather%20boots%20that%20offer%20a%20versatile%20and%20sophisticated%20footwear%20choice,%20perfect%20for%20all%20seasons.%3C/p%3E%0A%3Cp%3E-%20Perfect%20your%20ensemble%20with%20a%20lace-up%20closure,%20epitomizing%20versatile%20charm%20and%20adding%20an%20element%20of%20timeless%20refinement%20to%20your%20brown%20leather%20boot%20style.%3C/p%3E', 79.99, 'boots'),
    ('Adventure-Ready: Waterproof Hiking Boots', '%3Cp%3E-%20Gear%20up%20for%20adventure%20with%20waterproof%20hiking%20boots,%20offering%20the%20perfect%20blend%20of%20functionality%20and%20protection%20for%20your%20explorations.%3C/p%3E%0A%3Cp%3E-%20Step%20confidently%20into%20the%20great%20outdoors%20with%20hiking%20boots%20that%20endure%20the%20trail&apos;s%20challenges%20while%20providing%20unmatched%20comfort%20for%20your%20feet.%3C/p%3E%0A%3Cp%3E-%20Embrace%20the%20call%20of%20the%20wild%20with%20adventure-ready%20hiking%20boots,%20combining%20rugged%20reliability%20with%20a%20design%20that&apos;s%20tailor-made%20for%20the%20untamed%20outdoors.%3C/p%3E%0A%3Cp%3E-%20Conquer%20any%20terrain%20with%20the%20confidence%20of%20waterproof%20hiking%20boots,%20designed%20to%20withstand%20the%20elements%20and%20master%20diverse%20landscapes%20with%20ease.%3C/p%3E%0A%3Cp%3E-%20Perfect%20your%20outdoor%20ensemble%20with%20secure%20lace-up%20closure,%20epitomizing%20adventure-ready%20style%20and%20ensuring%20every%20step%20on%20your%20journey%20is%20met%20with%20confidence%20and%20durability.%3C/p%3E', 89.99, 'boots');

UPDATE "Shoe" SET image_link='https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/explore/1/1.png' WHERE id=1;
UPDATE "Shoe" SET image_link='https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/explore/2/2.png' WHERE id=2;
UPDATE "Shoe" SET image_link='https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/explore/3/3.png' WHERE id=3;
UPDATE "Shoe" SET image_link='https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/explore/4/4.png' WHERE id=4;
UPDATE "Shoe" SET image_link='https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/explore/5/5.png' WHERE id=5;
UPDATE "Shoe" SET image_link='https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/explore/6/6.png' WHERE id=6;

INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (1, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/explore/1/1.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (1, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/high-tops/2.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (1, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/high-tops/3.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (1, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/high-tops/4.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (1, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/high-tops/5.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (2, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/explore/2/2.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (2, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/high-tops/6.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (2, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/high-tops/7.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (2, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/high-tops/8.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (2, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/high-tops/9.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (3, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/explore/3/3.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (3, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/low-tops/1.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (3, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/low-tops/2.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (3, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/low-tops/3.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (3, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/low-tops/4.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (3, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/low-tops/4.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (4, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/explore/4/4.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (4, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/low-tops/5.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (4, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/low-tops/6.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (4, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/low-tops/7.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (5, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/explore/5/5.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (5, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/boots/1.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (5, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/boots/2.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (5, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/boots/3.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (5, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/boots/4.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (5, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/boots/5.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (6, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/explore/6/6.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (6, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/boots/6.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (6, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/boots/7.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (6, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/boots/8.png');
INSERT INTO "Shoe_Gallery"(shoe_id, image_link)
VALUES (6, 'https://nueqvbuobysxbgpelaih.supabase.co/storage/v1/object/public/shoes-explore/boots/9.png');

INSERT INTO "Shoe_Size"(size_name, type_id, gender)
VALUES
    ( '35', 'low-tops', 'M'),
    ( '36', 'low-tops', 'M'),
    ( '37', 'low-tops', 'M'),
    ( '38', 'low-tops', 'M'),
    ( '39', 'low-tops', 'M'),
    ( '40', 'low-tops', 'M'),
    ( '41', 'low-tops', 'M'),
    ( '42', 'low-tops', 'M'),
    ( '43', 'low-tops', 'M'),
    ( '44', 'low-tops', 'M'),
    ( '35', 'high-tops', 'M'),
    ( '36', 'high-tops', 'M'),
    ( '37', 'high-tops', 'M'),
    ( '38', 'high-tops', 'M'),
    ( '39', 'high-tops', 'M'),
    ( '40', 'high-tops', 'M'),
    ( '41', 'high-tops', 'M'),
    ( '42', 'high-tops', 'M'),
    ( '43', 'high-tops', 'M'),
    ( '44', 'high-tops', 'M'),
    ( '35', 'boots', 'M'),
    ( '36', 'boots', 'M'),
    ( '37', 'boots', 'M'),
    ( '38', 'boots', 'M'),
    ( '39', 'boots', 'M'),
    ( '40', 'boots', 'M'),
    ( '41', 'boots', 'M'),
    ( '42', 'boots', 'M'),
    ( '43', 'boots', 'M'),
    ( '44', 'boots', 'M'),
    ( '35', 'low-tops', 'W'),
    ( '36', 'low-tops', 'W'),
    ( '37', 'low-tops', 'W'),
    ( '38', 'low-tops', 'W'),
    ( '39', 'low-tops', 'W'),
    ( '40', 'low-tops', 'W'),
    ( '41', 'low-tops', 'W'),
    ( '42', 'low-tops', 'W'),
    ( '43', 'low-tops', 'W'),
    ( '44', 'low-tops', 'W'),
    ( '35', 'high-tops', 'W'),
    ( '36', 'high-tops', 'W'),
    ( '37', 'high-tops', 'W'),
    ( '38', 'high-tops', 'W'),
    ( '39', 'high-tops', 'W'),
    ( '40', 'high-tops', 'W'),
    ( '41', 'high-tops', 'W'),
    ( '42', 'high-tops', 'W'),
    ( '43', 'high-tops', 'W'),
    ( '44', 'high-tops', 'W'),
    ( '35', 'boots', 'W'),
    ( '36', 'boots', 'W'),
    ( '37', 'boots', 'W'),
    ( '38', 'boots', 'W'),
    ( '39', 'boots', 'W'),
    ( '40', 'boots', 'W'),
    ( '41', 'boots', 'W'),
    ( '42', 'boots', 'W'),
    ( '43', 'boots', 'W'),
    ( '44', 'boots', 'W');

INSERT INTO "Shoe_Extra" (title, image_link, description, price, type)
VALUES
    ('LED Light Strips', 'https://bhnjicatboqdydkqvuui.supabase.co/storage/v1/object/public/shoestylize/accessories/led.jpg?t=2023-10-29T23%3A51%3A16.026Z', 'Light up your steps with customizable LED light strips. Change colors and patterns on the go.', 19.99, 'accessory'),
    ('Shoe Cleaning Kit', 'https://bhnjicatboqdydkqvuui.supabase.co/storage/v1/object/public/shoestylize/accessories/kit.jpg?t=2023-10-29T23%3A51%3A25.614Z', 'Keep your shoes looking pristine with a comprehensive shoe cleaning kit.', 14.99, 'accessory');
