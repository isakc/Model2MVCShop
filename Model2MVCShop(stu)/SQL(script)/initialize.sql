DROP TABLE productImages CASCADE CONSTRAINTS;
DROP TABLE orderDetails CASCADE CONSTRAINTS;
DROP TABLE transaction CASCADE CONSTRAINTS;
DROP TABLE product CASCADE CONSTRAINTS;
DROP TABLE categories;
DROP TABLE users CASCADE CONSTRAINTS;
DROP TABLE cart;

DROP SEQUENCE seq_product_prod_no;
DROP SEQUENCE seq_transaction_tran_no;
DROP SEQUENCE seq_categories_category_no;
DROP SEQUENCE seq_orderdetails_order_no;
DROP SEQUENCE seq_productImages_img_no;

CREATE SEQUENCE seq_product_prod_no	 	 INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE seq_transaction_tran_no	 INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE seq_categories_category_no INCREMENT BY 1 START WITH 3000;
CREATE SEQUENCE seq_orderdetails_order_no INCREMENT BY 1 START WITH 3000;
CREATE SEQUENCE seq_cart_cart_no INCREMENT BY 1 START WITH 3000;
CREATE SEQUENCE seq_productImages_img_no INCREMENT BY 1 START WITH 10000;

CREATE TABLE users ( 
	user_id 			VARCHAR2(20)		NOT NULL,
	user_name 	VARCHAR2(50)		NOT NULL,
	password 		VARCHAR2(10)		NOT NULL,
	role 				VARCHAR2(5) 		DEFAULT 'user',
	ssn 					VARCHAR2(13),
	cell_phone	 VARCHAR2(14),
	addr 				VARCHAR2(100),
	email 				VARCHAR2(50),
	reg_date 		DATE,
	PRIMARY KEY(user_id)
);

CREATE TABLE categories(
	category_no NUMBER NOT NULL,
	parent_category_no NUMBER,
	category_name VARCHAR2(100),
	reg_date	 DATE,
	PRIMARY KEY(category_no)
);


CREATE TABLE product ( 
	prod_no 					NUMBER 				NOT NULL,
	prod_name 				VARCHAR2(100) 	NOT NULL,
	prod_detail 				VARCHAR2(200),
	manufacture_day	 VARCHAR2(8),
	price 							NUMBER(10),
	category_no NUMBER REFERENCES categories(category_no),
	quantity NUMBER,
	reg_date 					DATE,
	PRIMARY KEY(prod_no)
);

CREATE TABLE transaction ( 
	tran_no 						NUMBER 			NOT NULL,
	buyer_id 					VARCHAR2(20)	NOT NULL REFERENCES users(user_id),
	payment_option		 CHAR(3),
	receiver_name 		 VARCHAR2(20),
	receiver_phone		 VARCHAR2(14),
	demailaddr 				VARCHAR2(100),
	dlvy_request 			VARCHAR2(100),
	tran_status_code	 CHAR(3),
	order_data 				DATE,
	dlvy_date 				DATE,
	PRIMARY KEY(tran_no)
);

CREATE TABLE cart (
    cart_no NUMBER NOT NULL,
    user_id VARCHAR2(20) NOT NULL REFERENCES users(user_id),
    prod_no NUMBER NOT NULL REFERENCES product(prod_no),
    quantity NUMBER NOT NULL,
    PRIMARY KEY(cart_no)
);

CREATE TABLE orderDetails(
	order_no NUMBER NOT NULL,
	tran_no NUMBER NOT NULL REFERENCES transaction(tran_no),
	prod_no NUMBER NOT NULL REFERENCES product(prod_no),
	quantity NUMBER,
	reg_date DATE,
	PRIMARY KEY(order_no)
);

CREATE TABLE productImages(
	img_no NUMBER NOT NULL,
	file_name VARCHAR2(200),
	prod_no NUMBER NOT NULL REFERENCES product(prod_no),
	PRIMARY KEY(img_no)
);


INSERT 
INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date ) 
VALUES ( 'admin', 'admin', '1234', 'admin', NULL, NULL, '서울시 서초구', 'admin@mvc.com',TO_DATE('2012/01/14 10:48:43', 'YYYY/MM/DD HH24:MI:SS')); 

INSERT 
INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date ) 
VALUES ( 'manager', 'manager', '1234', 'admin', NULL, NULL, NULL, 'manager@mvc.com', TO_DATE('2012/01/14 10:48:43', 'YYYY/MM/DD HH24:MI:SS'));          

INSERT INTO users 
VALUES ( 'user01', 'SCOTT', '1111', 'user', NULL, NULL, NULL, NULL, SYSDATE); 

INSERT INTO users 
VALUES ( 'user02', 'SCOTT', '2222', 'user', NULL, NULL, NULL, NULL, SYSDATE); 

INSERT INTO users 
VALUES ( 'user03', 'SCOTT', '3333', 'user', NULL, NULL, NULL, NULL, SYSDATE); 

INSERT INTO users 
VALUES ( 'user04', 'SCOTT', '4444', 'user', NULL, NULL, NULL, NULL, SYSDATE); 

INSERT INTO users 
VALUES ( 'user05', 'SCOTT', '5555', 'user', NULL, NULL, NULL, NULL, SYSDATE); 

INSERT INTO users 
VALUES ( 'user06', 'SCOTT', '6666', 'user', NULL, NULL, NULL, NULL, SYSDATE); 

INSERT INTO users 
VALUES ( 'user07', 'SCOTT', '7777', 'user', NULL, NULL, NULL, NULL, SYSDATE); 

INSERT INTO users 
VALUES ( 'user08', 'SCOTT', '8888', 'user', NULL, NULL, NULL, NULL, SYSDATE); 

INSERT INTO users 
VALUES ( 'user09', 'SCOTT', '9999', 'user', NULL, NULL, NULL, NULL, SYSDATE); 

INSERT INTO users 
VALUES ( 'user10', 'SCOTT', '1010', 'user', NULL, NULL, NULL, NULL, SYSDATE); 

INSERT INTO users 
VALUES ( 'user11', 'SCOTT', '1111', 'user', NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO users 
VALUES ( 'user12', 'SCOTT', '1212', 'user', NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO users 
VALUES ( 'user13', 'SCOTT', '1313', 'user', NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO users 
VALUES ( 'user14', 'SCOTT', '1414', 'user', NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO users 
VALUES ( 'user15', 'SCOTT', '1515', 'user', NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO users 
VALUES ( 'user16', 'SCOTT', '1616', 'user', NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO users 
VALUES ( 'user17', 'SCOTT', '1717', 'user', NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO users 
VALUES ( 'user18', 'SCOTT', '1818', 'user', NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO users 
VALUES ( 'user19', 'SCOTT', '1919', 'user', NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO users 
VALUES ( 'user20', 'SCOTT', '2020', 'user', NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO users 
VALUES ( 'user21', 'SCOTT', '2121', 'user', NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO users 
VALUES ( 'user22', 'SCOTT', '2222', 'user', NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO users 
VALUES ( 'user23', 'SCOTT', '2323', 'user', NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO categories VALUES(seq_categories_category_no.NEXTVAL, 0, '가전디지털', SYSDATE);
INSERT INTO categories VALUES(seq_categories_category_no.NEXTVAL, 0, '스포츠/레저', SYSDATE);
INSERT INTO categories VALUES(seq_categories_category_no.NEXTVAL, 0, '완구/취미', SYSDATE);
INSERT INTO categories VALUES(seq_categories_category_no.NEXTVAL, 3000, '노트북', SYSDATE);
INSERT INTO categories VALUES(seq_categories_category_no.NEXTVAL, 3000, '모니터', SYSDATE);
INSERT INTO categories VALUES(seq_categories_category_no.NEXTVAL, 3001, '자전거', SYSDATE);
INSERT INTO categories VALUES(seq_categories_category_no.NEXTVAL, 3001, '스키/겨울장비', SYSDATE);
INSERT INTO categories VALUES(seq_categories_category_no.NEXTVAL, 3001, '인라인 스케이트', SYSDATE);
INSERT INTO categories VALUES(seq_categories_category_no.NEXTVAL, 3002, '원예/가드닝', SYSDATE);

INSERT INTO product VALUES (seq_product_prod_no.NEXTVAL,'vaio vgn FS70B','소니 바이오 노트북 신동품','20120514',2000000, '3003', 5, TO_DATE('2012/12/14 11:27:27', 'YYYY/MM/DD HH24:MI:SS'));
INSERT INTO product VALUES (seq_product_prod_no.NEXTVAL,'자전거','자전거 좋아요~','20120514',10000, '3005',5, TO_DATE('2012/11/14 10:48:43', 'YYYY/MM/DD HH24:MI:SS'));
INSERT INTO product VALUES (seq_product_prod_no.NEXTVAL,'보르도','최고 디자인 신품','20120201',1170000, '3004',5, TO_DATE('2012/10/14 10:49:39', 'YYYY/MM/DD HH24:MI:SS'));
INSERT INTO product VALUES (seq_product_prod_no.NEXTVAL,'보드세트','한시즌 밖에 안썼습니다. 눈물을 머금고 내놓음 ㅠ.ㅠ','20120217', 200000, '3006',5, TO_DATE('2012/11/14 10:50:58', 'YYYY/MM/DD HH24:MI:SS'));
INSERT INTO product VALUES (seq_product_prod_no.NEXTVAL,'인라인','좋아욥','20120819', 20000, '3007',5, TO_DATE('2012/11/14 10:51:40', 'YYYY/MM/DD HH24:MI:SS'));
INSERT INTO product VALUES (seq_product_prod_no.NEXTVAL,'삼성센스 2G','sens 메모리 2Giga','20121121',800000, '3003',5, TO_DATE('2012/11/14 18:46:58', 'YYYY/MM/DD HH24:MI:SS'));
INSERT INTO product VALUES (seq_product_prod_no.NEXTVAL,'연꽃','정원을 가꿔보세요','20121022',232300, '3008',5, TO_DATE('2012/11/15 17:39:01', 'YYYY/MM/DD HH24:MI:SS'));
INSERT INTO product VALUES (seq_product_prod_no.NEXTVAL,'삼성센스','노트북','20120212',600000, '3003',5, TO_DATE('2012/11/12 13:04:31', 'YYYY/MM/DD HH24:MI:SS'));

INSERT INTO productImages VALUES (seq_productImages_img_no.NEXTVAL, 'AHlbAAAAtBqyWAAA.jpg', 10000);
INSERT INTO productImages VALUES (seq_productImages_img_no.NEXTVAL, 'AHlbAAAAvetFNwAA.jpg', 10001);
INSERT INTO productImages VALUES (seq_productImages_img_no.NEXTVAL, 'AHlbAAAAvewfegAB.jpg', 10002);
INSERT INTO productImages VALUES (seq_productImages_img_no.NEXTVAL, 'AHlbAAAAve1WwgAC.jpg', 10003);
INSERT INTO productImages VALUES (seq_productImages_img_no.NEXTVAL, 'AHlbAAAAve37LwAD.jpg', 10004);
INSERT INTO productImages VALUES (seq_productImages_img_no.NEXTVAL, 'AHlbAAAAtBqyWAAA.jpg', 10005);
INSERT INTO productImages VALUES (seq_productImages_img_no.NEXTVAL, 'AHlbAAAAtDPSiQAA.jpg', 10006);
INSERT INTO productImages VALUES (seq_productImages_img_no.NEXTVAL, 'AHlbAAAAug1vsgAA.jpg', 10007);


commit;
