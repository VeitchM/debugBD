-- public.users definition

-- Drop table

-- DROP TABLE public.users;

-- DROP TYPE public."users_type_enum";
create extension if not exists "uuid-ossp"

CREATE TYPE if not exists public."users_type_enum" AS ENUM (
	'Admin',
	'CampusUser',
	'Professorship',
	'Scholarship',
	'Student');

-- DROP TYPE public."_users_type_enum";

CREATE TYPE public."_users_type_enum" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 4,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = public."users_type_enum",
	DELIMITER = ',');


CREATE TABLE public.users (
	id uuid NOT NULL DEFAULT uuid_generate_v4(),
	created_at timestamp NOT NULL DEFAULT now(),
	updated_at timestamp NOT NULL DEFAULT now(),
	deleted_at timestamp NULL,
	"version" int4 NOT NULL,
	uid varchar(36) NULL,
	full_name varchar NULL,
	email varchar NOT NULL,
	disabled bool NOT NULL DEFAULT false,
	dark_theme bool NOT NULL DEFAULT false,
	"type" public."users_type_enum" NOT NULL,
	available_storage int8 NULL,
	storage_used int8 NULL,
	balance numeric(8, 2) NULL,
	dni varchar NULL,
	available_copies int4 NULL,
	remaining_copies int4 NULL,
	campus_id uuid NULL,
	course_id uuid NULL,
	CONSTRAINT "PK_a3ffb1c0c8416b9fc6f907b7433" PRIMARY KEY (id),
	CONSTRAINT "REL_5156575a338031523af209fa4c" UNIQUE (campus_id),
	CONSTRAINT "REL_af2518518efa1699a1a24903de" UNIQUE (course_id),
	CONSTRAINT "UQ_5fe9cfa518b76c96518a206b350" UNIQUE (dni)
);
CREATE INDEX "IDX_94e2000b5f7ee1f9c491f0f8a8" ON public.users USING btree (type);
CREATE INDEX "IX_users_disabled" ON public.users USING btree (disabled);
CREATE INDEX "IX_users_email" ON public.users USING btree (email);
CREATE INDEX "IX_users_full_name" ON public.users USING btree (full_name);
CREATE INDEX "IX_users_uid" ON public.users USING btree (uid);


-- public.users foreign keys

ALTER TABLE public.users ADD CONSTRAINT "FK_5156575a338031523af209fa4c8" FOREIGN KEY (campus_id) REFERENCES public.campus(id);
ALTER TABLE public.users ADD CONSTRAINT "FK_af2518518efa1699a1a24903de9" FOREIGN KEY (course_id) REFERENCES public.courses(id);


INSERT INTO public.users (id,created_at,updated_at,deleted_at,"version",uid,full_name,email,disabled,dark_theme,"type",available_storage,storage_used,balance,dni,available_copies,remaining_copies,campus_id,course_id) VALUES
	 ('99b0613b-68b1-4503-8d53-13c72fd0251c','2022-11-17 18:41:15.999033','2022-11-17 18:41:25.037416',NULL,2,'NyhyBKjexYP2VJYofo2aYsmIHIs1','joaquin','joacocampc@gmail.com',false,false,'Student',NULL,NULL,0.00,'44264704',NULL,NULL,NULL,NULL),
	 ('98179da5-c1b0-4132-9bc0-6685f38a871a','2022-11-17 18:19:50.712413','2022-11-17 18:41:58.967289',NULL,4,'EZHhi8qbXVdpcjEn01rlrHrchwq1','franco','murakamifranco@gmail.com',false,false,'Student',NULL,NULL,0.00,'44667874',NULL,NULL,NULL,NULL),
	 ('ee72c505-b6b0-43d6-b7ec-f295a0b68b76','2022-11-17 18:42:44.425652','2022-11-22 17:08:11.793093',NULL,3,'kqReEwdPRiZVltAkpiHlVaD3oKC3','Prueba2','eesn2celoberia@gmail.com',false,false,'Student',NULL,NULL,100.00,'0000001',NULL,NULL,NULL,NULL),
	 ('4486a4ab-7b03-487e-9343-1eff3ced87a5','2022-11-17 16:18:57.038839','2022-11-22 21:52:01.271159',NULL,3,'smHkPG1J53hAd9kcwJwNsDBddo33','Morena Pose','morenapose1@gmail.com',false,true,'Student',NULL,NULL,0.00,'45923119',NULL,NULL,NULL,NULL),
	 ('cd0b2b25-f5d4-41d5-bc44-4a021124c4f1','2022-11-17 18:58:54.530405','2022-11-17 18:59:52.324118',NULL,3,'7CeuPqX9ftYAl7HOgPNH4l3zdiG2','Bruno','morillabruno10@gmail.com',false,true,'Student',NULL,NULL,0.00,'43854584',NULL,NULL,NULL,NULL),
	 ('a774a2d5-8ef5-4ca7-84cb-33c4c458c034','2022-11-17 19:12:47.668012','2022-11-17 19:14:50.067089',NULL,4,'o7u9Fp09B9dpDSGWTqE0n5dqdl52','Dario','kdfunes@outlook.com',false,false,'Student',NULL,NULL,0.00,'43853163',NULL,NULL,NULL,NULL),
	 ('8b346109-a14f-416d-86fd-eadc0f88f06c','2022-11-17 19:15:33.305789','2022-11-17 19:15:58.54023',NULL,2,'WSjnRlba5PTiQFfw771uHtTdVPk2','Sebastian Adorisio','sebi.adorisio@gmail.com',false,false,'Student',NULL,NULL,0.00,'42720137',NULL,NULL,NULL,NULL),
	 ('80eb8925-9884-46b3-996a-1e66aad96485','2022-11-15 14:46:41.585773','2022-11-15 14:46:41.585773',NULL,1,'80eb8925-9884-46b3-996a-1e66aad96485','Admin','cei.unmdp@gmail.com',false,false,'Admin',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	 ('f60872fd-1eec-4feb-9388-034d9774c559','2022-11-17 19:17:22.635027','2022-11-17 19:17:40.323254',NULL,2,'m5jKUfPu9gh2uzfeORuHKSmOhKz1','Rocio','rochisuareez@gmail.com',false,false,'Student',NULL,NULL,0.00,'42089370',NULL,NULL,NULL,NULL),
	 ('5c3359ee-45fe-4fe9-b1df-0dbf39800f9a','2022-11-17 19:24:26.081493','2022-11-17 19:24:33.459815',NULL,2,'qOZnDUUTtMP7cAiWDwiTniZC3jk1','Santiago Ramos Franzese','santiagoramosfranzese@gmail.com',false,false,'Student',NULL,NULL,0.00,'44545984',NULL,NULL,NULL,NULL);
INSERT INTO public.users (id,created_at,updated_at,deleted_at,"version",uid,full_name,email,disabled,dark_theme,"type",available_storage,storage_used,balance,dni,available_copies,remaining_copies,campus_id,course_id) VALUES
	 ('062ae0c6-80c0-4018-9495-6bb47298c976','2022-11-17 19:45:26.385382','2022-11-17 19:45:41.545356',NULL,2,'uVwaDTM4d1QnDXmfw3wCSjmF6bQ2','Santiago Martinez ','santiagomartineznh@gmail.com',false,false,'Student',NULL,NULL,0.00,'45539083',NULL,NULL,NULL,NULL),
	 ('80c2a42f-ece4-40ad-8c73-82b6ca4c44e3','2022-11-17 19:52:55.376311','2022-11-17 19:53:06.201431',NULL,2,'HVu1kUIAdqVV1HNjoAjVpnq9GVB3','Federico','fedeslaven47@gmail.com',false,false,'Student',NULL,NULL,0.00,'43986115',NULL,NULL,NULL,NULL),
	 ('1eb57dfc-a4d2-4814-9038-d58ec408c5d9','2022-11-17 20:04:13.811181','2022-11-17 20:04:29.32045',NULL,2,'ltHAvSOzL3OfQ6aaAG0qGPkBh0y1','jose','pepipiantoni3183@gmail.com',false,false,'Student',NULL,NULL,0.00,'44858673',NULL,NULL,NULL,NULL),
	 ('fd293e9e-1589-4d63-a92c-b7cd9410338e','2022-11-15 15:21:19.917015','2022-11-15 15:21:20.656113',NULL,2,'0vynBRZ7ZLTS0FZSO7TJmF91dSG2','Matias Veitch','matiasveitch@gmail.com',false,false,'Student',NULL,NULL,0.00,'40025649',NULL,NULL,NULL,NULL),
	 ('5b55e72c-c88c-4f45-8bee-0e0e46705212','2022-11-17 20:28:45.298154','2022-11-17 20:29:24.217001',NULL,2,'hV1q4n07LyOVa7w1IeGGlbYmVva2','Matias Nahuel Puebla','matiaspuebla103@gmail.com',false,false,'Student',NULL,NULL,0.00,'45031078',NULL,NULL,NULL,NULL),
	 ('8387c5aa-dccf-4440-9bbd-00e5cc9a5340','2022-11-15 15:23:11.821889','2022-11-15 15:25:48.143487',NULL,2,'Pfh0Dz8EzvhD3zONEjDJt7MFz8N2','Matias Veitch2','kingdiosupremo@gmail.com',false,false,'Student',NULL,NULL,0.00,'40025650',NULL,NULL,NULL,NULL),
	 ('1231a210-b94b-48d1-8578-79558fda0f7f','2022-11-17 20:50:22.872397','2022-11-17 20:51:10.488546',NULL,3,'rzPtOR2XQxXd5lrPndYu1eve0pC3','Cristian','cristianntorrecillas16@gmail.com',false,true,'Student',NULL,NULL,0.00,'94247671',NULL,NULL,NULL,NULL),
	 ('350b5a71-f90d-417a-b9d8-65c7a0c89c3f','2022-11-17 16:02:12.140404','2022-11-17 16:02:23.461646',NULL,2,'dCz0cT53y5N5xQ49S7k9EQbTRwI2','Nicolas Fioriti','nicfio27@gmail.com',false,false,'Student',NULL,NULL,0.00,'44957039',NULL,NULL,NULL,NULL),
	 ('d6299b0c-db8d-4f0d-a283-ab6968dac1bf','2022-11-17 20:59:26.465737','2022-11-17 20:59:26.465737',NULL,1,'VMFktrwSIhTtxLm1EbrFSnknmGg2','Dolores Rial','doloresrialthomas@gmail.com',false,false,'Student',NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL),
	 ('eba2e3c0-40b8-48fc-b8ba-10f749da48f9','2022-11-17 16:16:56.782289','2022-11-17 16:17:08.587898',NULL,2,'ydZgXTRo0hb0AFB1waRsgPtG8IV2','Bruno Tosetti ','btosetti3443@gmail.com',false,false,'Student',NULL,NULL,0.00,'452911108',NULL,NULL,NULL,NULL);
INSERT INTO public.users (id,created_at,updated_at,deleted_at,"version",uid,full_name,email,disabled,dark_theme,"type",available_storage,storage_used,balance,dni,available_copies,remaining_copies,campus_id,course_id) VALUES
	 ('6995f005-1d41-4dcf-891b-247da4d1301f','2022-11-17 16:56:15.064881','2022-11-17 16:57:43.283503',NULL,2,'3zNKUGgw3yMDXEvdxwwjfUhj3rK2','Lara','laratodorovich2@gmail.com',false,false,'Student',NULL,NULL,0.00,'42343274',NULL,NULL,NULL,NULL),
	 ('e2436cf0-8465-4229-ad6c-f35a47c317b2','2022-11-18 02:29:40.235338','2022-11-18 02:29:53.783417',NULL,2,'9TpSVYha5aNc3GrNYUM3qL0fPW43','Lucas','lucastomasrios@gmail.com',false,false,'Student',NULL,NULL,0.00,'44692556',NULL,NULL,NULL,NULL),
	 ('273215ff-4509-49cc-8814-259239188a97','2022-11-17 15:56:36.495842','2022-11-18 00:07:36.311131',NULL,4,'u825U44kldNzzbu83mj11IGNGMr1','Diego Aceña','dmacena@gmail.com',false,false,'Student',NULL,NULL,0.00,'23224817',NULL,NULL,NULL,NULL),
	 ('2b03c33e-3b39-476b-bdf7-7db88461935c','2022-11-17 21:21:44.593693','2022-11-17 21:46:40.363392',NULL,5,'7SVqALWZ91drwFYrgJUvSAMXkiP2','Paz Corvalan','mpazcorvalan2003@gmail.com',false,true,'Student',NULL,NULL,0.00,'45291153',NULL,NULL,NULL,NULL),
	 ('a6695e29-1982-4b4f-b6e2-9117af78cd51','2022-11-17 17:16:54.921232','2022-11-17 17:17:11.557371',NULL,2,'2WdrzNt2mWZiQwtfG58h2jS5fmM2','Mateo Fernandez','mateofernandez210802@gmail.com',false,false,'Student',NULL,NULL,0.00,'44336187',NULL,NULL,NULL,NULL),
	 ('e8486005-b14c-4bdb-97e4-0040fece18f1','2022-11-17 21:51:03.419627','2022-11-17 21:51:32.49942',NULL,2,'TyT1fd5XRtQQdvHTwjZWQKrsjnb2','luca','lucasperanza2001@gmail.com',false,false,'Student',NULL,NULL,0.00,'43471405',NULL,NULL,NULL,NULL),
	 ('93fff459-2b4b-42b8-9167-f485d332f43c','2022-11-17 17:11:23.13494','2022-11-17 17:11:38.873535',NULL,2,'Ca6FjQPMiqgb1X5zPWdSXu132Wk2','Maria de los Angeles ','angelesf1550@gmail.com',false,false,'Student',NULL,NULL,0.00,'42455461',NULL,NULL,NULL,NULL),
	 ('e9689292-281c-42da-864a-0c26ce60c84f','2022-11-17 21:51:48.011324','2022-11-17 21:51:56.571346',NULL,2,'CFbl63G8YpX7a0zrajgMqSGLXQz1','franco ferrera','francohd3@gmail.com',false,false,'Student',NULL,NULL,0.00,'45220557',NULL,NULL,NULL,NULL),
	 ('a8cce63e-6239-48dc-880d-21e03512f9b8','2022-11-17 22:50:56.032448','2022-11-17 22:51:06.87442',NULL,2,'y8SpElfeN6WRWLVRXYsuDgjjqJ42','maximaur','uriartemaxima@gmail.com',false,false,'Student',NULL,NULL,0.00,'50204643',NULL,NULL,NULL,NULL),
	 ('f47f2f8c-51aa-4301-a8f5-f1430641cbbb','2022-11-17 17:30:14.383232','2022-11-17 17:30:32.085338',NULL,2,'Lb8Grz3k1lYUh6gx5H1yfvypIHX2','Valeria Marinissen','valemarinissen@gmail.com',false,false,'Student',NULL,NULL,0.00,'42597440',NULL,NULL,NULL,NULL);
INSERT INTO public.users (id,created_at,updated_at,deleted_at,"version",uid,full_name,email,disabled,dark_theme,"type",available_storage,storage_used,balance,dni,available_copies,remaining_copies,campus_id,course_id) VALUES
	 ('4f8a3476-6c1e-43ee-804a-34897ab510e6','2022-11-17 17:30:41.074266','2022-11-17 17:30:51.309283',NULL,2,'L3bxcMnVW8YvJqoftcImUfgp3gZ2','Federico','fede6365@gmail.com',false,false,'Student',NULL,NULL,0.00,'40580030',NULL,NULL,NULL,NULL),
	 ('94a73972-8347-4199-9d15-879e55ee71be','2022-11-18 01:53:04.035829','2022-11-18 01:54:29.538608',NULL,2,'nKCnlx77ltMro7Ggo0q1abYfnde2','Agustina','agustinacebedio2003@gmail.com',false,false,'Student',NULL,NULL,0.00,'44619391',NULL,NULL,NULL,NULL),
	 ('26785c78-070f-4c8e-a646-45388ee04a19','2022-11-17 17:32:30.779503','2022-11-17 17:32:39.931749',NULL,2,'jXfjiUdCtKVSOJRfMb4PVFmnUwG3','Carolina Olalde','asensioolalde@gmail.com',false,false,'Student',NULL,NULL,0.00,'49640335',NULL,NULL,NULL,NULL),
	 ('3941af05-07a6-4693-aad3-4a1d593657a6','2022-11-18 01:50:27.653509','2022-11-18 01:58:52.425723',NULL,3,'Avpxeagc7Ofwjn0OjAw21Qu93jp1','Matías','matias.romero93@yahoo.com',false,true,'Student',NULL,NULL,0.00,'43784573',NULL,NULL,NULL,NULL),
	 ('6a57da1f-a7d9-44f9-9638-f3d91ad0dfe2','2022-11-17 17:50:56.902319','2022-11-17 17:51:28.768036',NULL,2,'rqcFN9gztwQHGjtrhBgeu8RHhwX2','Camila','camijordan97@gmail.com',false,false,'Student',NULL,NULL,0.00,'40864310',NULL,NULL,NULL,NULL),
	 ('78c4fc48-6a81-4fb0-8777-65fe676a0047','2022-11-17 17:03:32.523595','2022-11-17 17:55:49.992891',NULL,5,'78c4fc48-6a81-4fb0-8777-65fe676a0047','Impresiones','impresiones_cei@fi.mdp.edu.ar',false,true,'CampusUser',NULL,NULL,NULL,NULL,NULL,NULL,'73b511bd-99db-4a7c-99c9-7d628a890045',NULL),
	 ('77b595ef-fb19-49e2-a7d1-e4a710f330fb','2022-11-18 02:39:37.947302','2022-11-18 02:40:10.118599',NULL,2,'fkNv66aIpdU2XQvyVwFZtkYL7k12','luz','luzintas@gmail.com',false,false,'Student',NULL,NULL,0.00,'41430255',NULL,NULL,NULL,NULL),
	 ('9f451842-b15a-404e-a57d-7bf5fed69af3','2022-11-17 18:01:51.025015','2022-11-17 18:02:05.610495',NULL,2,'PhHVqknqZzLdOYTtPXpjrkUKEaE2','Tomas Quattrini','tomasquattrini1@gmail.com',false,false,'Student',NULL,NULL,0.00,'44859877',NULL,NULL,NULL,NULL),
	 ('54c59646-4e7b-48bd-9ec1-ec3ffae0d6ab','2022-11-17 18:09:21.793296','2022-11-17 18:09:31.073941',NULL,2,'p8CYM8zcP8XzlnbgNwpxKvRMyhu1','Rebeca','rebecadiez007@gmail.com',false,false,'Student',NULL,NULL,0.00,'44784007',NULL,NULL,NULL,NULL),
	 ('86a8e720-4fcd-4482-b420-73bdbbb2f0c7','2022-11-18 03:39:11.787902','2022-11-18 03:39:28.841391',NULL,2,'xmOlPFZ7xgUH40eYZpw1HGWyKms1','matias','matiasstrassera010@gmail.com',false,false,'Student',NULL,NULL,0.00,'42946499',NULL,NULL,NULL,NULL);
INSERT INTO public.users (id,created_at,updated_at,deleted_at,"version",uid,full_name,email,disabled,dark_theme,"type",available_storage,storage_used,balance,dni,available_copies,remaining_copies,campus_id,course_id) VALUES
	 ('55b4bb3b-c44b-432c-85b1-27e04aa900c3','2022-11-17 18:10:29.251609','2022-11-17 18:11:03.099797',NULL,2,'pJkEN1tK3dh29mx6bHNAS9DUPIC3','Hernán Foa ','hfoa123@gmail.com',false,false,'Student',NULL,NULL,0.00,'44783549',NULL,NULL,NULL,NULL),
	 ('03a2cca6-4e4b-4131-845b-424895312222','2022-11-18 05:50:09.264222','2022-11-18 05:50:47.792876',NULL,2,'2ppNcDxarCOcpDjPAoZ0z57zECF2','jeremias Ramirez','jereramirez2537@gmail.com',false,false,'Student',NULL,NULL,0.00,'94298553',NULL,NULL,NULL,NULL),
	 ('4029b800-8a37-45ff-895f-3711ba6bed6e','2022-11-18 10:23:38.810305','2022-11-18 10:23:50.252788',NULL,2,'xUpvYgWx5kUOyfuhJNkdkRIIIHy2','Eugenio Fernández','eugeniofernandez2004@gmail.com',false,false,'Student',NULL,NULL,0.00,'45576693',NULL,NULL,NULL,NULL),
	 ('f1999878-120b-4227-a8e4-0d449bf16d78','2022-11-18 10:50:01.292577','2022-11-18 10:50:32.212059',NULL,2,'bKpE5CXI8FaSoQnQ7mLa8OyQMe03','Rocio','rocioayekenkren@gmail.com',false,false,'Student',NULL,NULL,0.00,'43855942',NULL,NULL,NULL,NULL),
	 ('2b5274fc-6099-4063-856e-6062021080c0','2022-11-18 12:01:03.33354','2022-11-18 12:01:13.194819',NULL,2,'4qXu1Mw1vJZ6ExsKMOPj0iV4JY52','Serena Asensio','asensio.se@gmail.com',false,false,'Student',NULL,NULL,0.00,'45741526',NULL,NULL,NULL,NULL),
	 ('05f93a0c-c833-4a88-8e72-fdcc209294df','2022-11-18 12:14:56.975577','2022-11-18 12:15:41.775017',NULL,4,'qy2Biu2E4qTyiiEqQr6TN4pTiJ43','Facundo','facuiampietro@gmail.com',false,false,'Student',NULL,NULL,0.00,'45741590',NULL,NULL,NULL,NULL),
	 ('f41950af-2848-460e-b08e-6cac62e438af','2022-11-18 12:33:19.585847','2022-11-18 12:33:30.643649',NULL,2,'YbXA5VBf2CPFqkDJp6aHDoakdfI3','valentina','valenlopezbayerque@gmail.com',false,false,'Student',NULL,NULL,0.00,'44860470',NULL,NULL,NULL,NULL),
	 ('ea210fb0-7443-4a30-866a-2e2b5b123921','2022-11-18 13:22:44.251114','2022-11-18 13:22:51.892785',NULL,2,'nNDLntK5OvftNYU1YYd3OEV0ijv2','Ignacio Iarossi','iarossinacho2003@gmail.com',false,false,'Student',NULL,NULL,0.00,'44784047',NULL,NULL,NULL,NULL),
	 ('b56969d8-7532-45ab-8838-c840b295bb27','2022-11-18 13:52:09.705358','2022-11-18 13:52:09.705358',NULL,1,'wVA4OKi9e7getflmChfIsaNwbPH3','Ian','ianmateotarnowski@gmail.com',false,false,'Student',NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL),
	 ('2f790e38-4cef-43e2-a314-dd232caaae3d','2022-11-18 13:56:10.987691','2022-11-18 13:56:21.05372',NULL,2,'1gKAOPDNy9hlg22Etz7w4gYSnGm2','Lola','adlerlola4@gmail.com',false,false,'Student',NULL,NULL,0.00,'45567502',NULL,NULL,NULL,NULL);
INSERT INTO public.users (id,created_at,updated_at,deleted_at,"version",uid,full_name,email,disabled,dark_theme,"type",available_storage,storage_used,balance,dni,available_copies,remaining_copies,campus_id,course_id) VALUES
	 ('16b1698e-d1f5-447a-9087-59dafc20552d','2022-11-19 21:01:23.690956','2022-11-19 21:01:36.438061',NULL,2,'o1ruBewLmSgX3LOtFwSJ4Oe80kL2','Taiel ','taielisidro@gmail.com',false,false,'Student',NULL,NULL,0.00,'43458682',NULL,NULL,NULL,NULL),
	 ('841987e8-8ff9-4beb-a35d-3de76a485433','2022-11-18 14:02:16.58841','2022-11-18 14:02:29.445014',NULL,2,'9CuIiyATPiXZcpOYTHJKhGwHMbE3','Sofia','sofiigarayolindi.sgo@gmail.com',false,false,'Student',NULL,NULL,0.00,'43595987',NULL,NULL,NULL,NULL),
	 ('fb0ea180-a383-4093-90a3-975438c6dc94','2022-11-21 19:14:30.514223','2022-11-21 19:14:56.568093',NULL,2,'YwmiJxNwMzUlT4fAvDKPmQmt2Uq1','Oriana Notti','oriananotti@hotmail.com',false,false,'Student',NULL,NULL,0.00,'45220234',NULL,NULL,NULL,NULL),
	 ('2a686672-57d9-47ee-969c-e0029511c957','2022-11-18 14:23:22.891367','2022-11-18 14:24:24.195344',NULL,2,'czd4HmBe1MM6yIsFmrs18DcrA6y1','Valentin','valentingverdi@gmail.com',false,false,'Student',NULL,NULL,0.00,'44957479',NULL,NULL,NULL,NULL),
	 ('5824f20b-f605-464f-9489-1567f5c10a8e','2022-11-19 21:23:57.483626','2022-11-19 21:24:12.533404',NULL,2,'901c4hM9aMTpE1z6xleKKGXkI933','Gian Franco Magliotti Mendiburu','gianmagliotti03@gmail.com',false,false,'Student',NULL,NULL,0.00,'44770903',NULL,NULL,NULL,NULL),
	 ('05217142-24a4-45c2-b87b-9868b77bf1f2','2022-11-18 14:24:53.327078','2022-11-18 14:25:03.794468',NULL,2,'ZDpL3pX0s9SxOTo6vIBZUsaHih93','Juan Ignacio Donadio','juanidg21@gmail.com',false,false,'Student',NULL,NULL,0.00,'42461764',NULL,NULL,NULL,NULL),
	 ('9c2418f0-48ee-443b-ae78-fc2eeb8fe42a','2022-11-18 15:02:24.594261','2022-11-18 15:02:38.951245',NULL,2,'CAXeH1o3THXYMWaf5JuCFH8925o1','delfina','delfinamartinez1211@gmail.com',false,false,'Student',NULL,NULL,0.00,'43784247',NULL,NULL,NULL,NULL),
	 ('4f59c758-3d79-402a-a34d-330d5403589a','2022-11-19 21:59:00.020894','2022-11-19 22:00:02.492244',NULL,2,'FcyLVHPZMRfhIAb05lUHsyWIAto1','Lucas ','alegrelucas98@gmail.com',false,false,'Student',NULL,NULL,0.00,'44859283',NULL,NULL,NULL,NULL),
	 ('97dda2ad-b5db-4f05-94b7-2fdbf3e49474','2022-11-19 22:26:02.927532','2022-11-19 22:26:02.927532',NULL,1,'jagCSWZrU4ezcVB0idRIBzbwhGG2','Nico','bravo.niconicolas@gmail.com',false,false,'Student',NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL),
	 ('1a210061-d5f2-453b-aac1-7a694c20afe8','2022-11-18 16:57:21.553608','2022-11-18 16:57:54.587361',NULL,4,'t9AEbxGgMYVAOPUbi74WOmTqlEU2','Joaquin Vazquez','joaquinvazquezfrecino@live.com.ar',false,false,'Student',NULL,NULL,0.00,'43508223',NULL,NULL,NULL,NULL);
INSERT INTO public.users (id,created_at,updated_at,deleted_at,"version",uid,full_name,email,disabled,dark_theme,"type",available_storage,storage_used,balance,dni,available_copies,remaining_copies,campus_id,course_id) VALUES
	 ('fbe6300e-1efb-4a51-85ab-6b1a44b8a6c2','2022-11-18 16:46:26.773867','2022-11-18 17:03:26.121187',NULL,2,'BXqiQXRAHGW1y2lT144oX8FJtac2','Ezequiel Loinaz','zequeloinaz@gmail.com',false,false,'Student',NULL,NULL,0.00,'44860334',NULL,NULL,NULL,NULL),
	 ('cf657b35-70eb-4b9a-b245-919a3d739d75','2022-11-19 22:26:02.947834','2022-11-19 22:26:02.947834',NULL,1,'jagCSWZrU4ezcVB0idRIBzbwhGG2','Nico','bravo.niconicolas@gmail.com',false,false,'Student',NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL),
	 ('97b37294-b48f-4b73-946a-ffe767bf3b74','2022-11-18 17:48:17.261294','2022-11-18 17:48:32.949372',NULL,2,'BBa26qVD8qRkKB4Krzu9n4wWaVI3','Magdalena','maguibotto03@gmail.com',false,false,'Student',NULL,NULL,0.00,'44859586',NULL,NULL,NULL,NULL),
	 ('a078f998-5c41-465a-a1bd-59f3372c8817','2022-11-19 22:26:02.89614','2022-11-19 22:26:29.203133',NULL,2,'jagCSWZrU4ezcVB0idRIBzbwhGG2','Nico','bravo.niconicolas@gmail.com',false,false,'Student',NULL,NULL,0.00,'45400086',NULL,NULL,NULL,NULL),
	 ('fd62db35-37e6-4abd-bb4d-9036b053de72','2022-11-18 17:51:02.31218','2022-11-18 17:51:21.259903',NULL,2,'S5OKTgJXKbbe2rxTemWXNfQLITz2','Milagros','milagrosgotthelf@gmail.com',false,false,'Student',NULL,NULL,0.00,'45923379',NULL,NULL,NULL,NULL),
	 ('9f9ffcca-31e0-4adb-a899-7de856b0dc64','2022-11-19 23:25:57.304875','2022-11-19 23:26:09.810087',NULL,2,'x5PbqOBreQOtbVGfVTbxEZ74IOG3','Facundo iribarne','iribarnefacu@gmail.com',false,false,'Student',NULL,NULL,0.00,'44335717',NULL,NULL,NULL,NULL),
	 ('9d41fb1a-796d-4f44-91d7-54e1ef1fa043','2022-11-18 17:52:39.884643','2022-11-18 17:52:50.287115',NULL,2,'irCSuIgtUkNY8wewTkvEPLxKfFF3','Ezequiel','ezequielpreussler@gmail.com',false,false,'Student',NULL,NULL,0.00,'45131224',NULL,NULL,NULL,NULL),
	 ('c32441c5-2bc3-456b-b448-78af17d5024f','2022-11-18 19:09:53.321532','2022-11-18 19:10:14.313282',NULL,2,'sB48SSOVBHUbeVHWBNoOfecdtES2','Fabricio Farnos','fabriciofarnos22@gmail.com',false,false,'Student',NULL,NULL,0.00,'42042396',NULL,NULL,NULL,NULL),
	 ('82cdc302-fcc6-44d1-9512-b6c74dbb8a6d','2022-11-18 17:52:29.70276','2022-11-18 17:53:42.618898',NULL,4,'VB8NXJ6YBbVXNJr5M3eHDsVqBUk2','Augusto Di Leva','androide0223@gmail.com',false,false,'Student',NULL,NULL,0.00,'44858756',NULL,NULL,NULL,NULL),
	 ('8d892afd-a54d-4e21-99b0-191f5d6d1225','2022-11-20 00:02:20.630861','2022-11-20 00:02:58.313047',NULL,2,'fHTIEAWOPVZ5js3KLwtQfshq6yh1','Lemuel E. Cotado','lemucot@gmail.com',false,false,'Student',NULL,NULL,0.00,'43740911',NULL,NULL,NULL,NULL);
INSERT INTO public.users (id,created_at,updated_at,deleted_at,"version",uid,full_name,email,disabled,dark_theme,"type",available_storage,storage_used,balance,dni,available_copies,remaining_copies,campus_id,course_id) VALUES
	 ('4f2d5743-3b2d-493a-9a09-1a30210bba1e','2022-11-18 17:56:34.704267','2022-11-18 17:56:47.085172',NULL,2,'35q5VNSWZ9Q8eXT2dPzQm7JJJ8f1','Abril','abrilnoelsolano@gmail.com',false,false,'Student',NULL,NULL,0.00,'42499493',NULL,NULL,NULL,NULL),
	 ('9e32a891-07b4-458b-bad7-d3b4d6c3c924','2022-11-18 17:56:32.962184','2022-11-18 17:57:16.060869',NULL,2,'osbMVp1wfCYLIM6nMCrOa9OuFC43','david','davidginaca@gmail.com',false,false,'Student',NULL,NULL,0.00,'33102631',NULL,NULL,NULL,NULL),
	 ('6578c90a-83f4-4a0d-bab0-7d6c02b2bca1','2022-11-18 17:58:40.67851','2022-11-18 17:58:52.635346',NULL,2,'jiPnydDyu4UEs79AFgS8ZpZzoZ53','sebastian ','sebasciava@gmail.com',false,false,'Student',NULL,NULL,0.00,'45130763',NULL,NULL,NULL,NULL),
	 ('c09d190e-eea4-421a-9768-c86a275c2654','2022-11-20 02:28:31.397461','2022-11-20 02:28:39.28691',NULL,2,'uJbUSdsnlKXxwhGVzHXnZ9AoAMT2','Joaquín Montaña ','montanaj504@gmail.com',false,false,'Student',NULL,NULL,0.00,'42958482',NULL,NULL,NULL,NULL),
	 ('2b854aad-f06a-4aee-9fc9-0a0468cba17d','2022-11-18 18:12:52.392289','2022-11-18 18:13:25.497598',NULL,2,'zH2WB4YyQeUW80uMyEwtDZ9UrCK2','Juan','juanisanchez912@gmail.com',false,false,'Student',NULL,NULL,0.00,'43455270',NULL,NULL,NULL,NULL),
	 ('2188b058-37de-4918-89d9-a3133845f890','2022-11-20 02:45:08.761697','2022-11-20 02:45:18.033797',NULL,2,'uFHk4jaSbMZk7OnPjlvCEf4Zbx83','simon','simon.nivio@gmail.com',false,false,'Student',NULL,NULL,0.00,'43255294',NULL,NULL,NULL,NULL),
	 ('c5aeabca-8e4b-49ae-b9b0-9898ce83fa73','2022-11-18 18:27:47.980106','2022-11-18 18:29:33.842168',NULL,3,'I0QunYsgH9QaPeXApQU0SoRfpne2','Nomequieroregistrar','keyejil579@lance7.com',false,true,'Student',NULL,NULL,0.00,'44692202',NULL,NULL,NULL,NULL),
	 ('835212ca-ae92-4626-b52f-ef8ea9b59a00','2022-11-18 18:27:51.014053','2022-11-18 18:31:16.479355',NULL,3,'5IrKbkOX0ibioSkh29129fuumzh2','Ezequiel Arce','ezequielarce449@gmail.com',false,true,'Student',NULL,NULL,0.00,'45820204',NULL,NULL,NULL,NULL),
	 ('4bfcf978-135e-4f26-98fd-57b2bed4f310','2022-11-20 13:15:54.600585','2022-11-20 13:16:02.795474',NULL,2,'KEo0LDAG2dgCvWO8SPcZ5Z93aFG2','Juan','jjdiazmdp@gmail.com',false,false,'Student',NULL,NULL,0.00,'32937063',NULL,NULL,NULL,NULL),
	 ('17ae3bb5-27e6-44d1-afa3-2d52048536a2','2022-11-18 19:00:35.787816','2022-11-18 19:01:01.374565',NULL,3,'QAQWy6FBzVY6L9XL0rQAcNe0ihQ2','Pedro dieguez buccella','pedrodieguez2000@gmail.com',false,true,'Student',NULL,NULL,0.00,'42629896',NULL,NULL,NULL,NULL);
INSERT INTO public.users (id,created_at,updated_at,deleted_at,"version",uid,full_name,email,disabled,dark_theme,"type",available_storage,storage_used,balance,dni,available_copies,remaining_copies,campus_id,course_id) VALUES
	 ('d7f7c54c-7527-405d-b7d7-331a3203a6dd','2022-11-20 14:15:16.058102','2022-11-20 14:16:02.227942',NULL,2,'ATzyZxOCX9MAIxmWk0li11rMwYB3','Ignacio','nachorod2003@gmail.com',false,false,'Student',NULL,NULL,0.00,'44860107',NULL,NULL,NULL,NULL),
	 ('c0f6039c-5a1b-40a9-a196-96f22630bcfa','2022-11-18 19:17:23.623592','2022-11-18 19:17:35.747865',NULL,2,'eBTkxMU4XfRL78AHNelnyHvzy403','Victoria','mancinivictoria22@gmail.com',false,false,'Student',NULL,NULL,0.00,'42157604',NULL,NULL,NULL,NULL),
	 ('c48c8768-cce1-4144-b918-0bd465331921','2022-11-18 19:10:26.26325','2022-11-18 19:20:10.065974',NULL,3,'cm74Ph5RaLXBvy3I2vYVyORrojs2','Julieta','tolcachjulieta0810@gmail.com',false,true,'Student',NULL,NULL,0.00,'44459868',NULL,NULL,NULL,NULL),
	 ('a583afb3-ab78-4dfe-8886-0d8cedfaf8d9','2022-11-19 19:53:13.155436','2022-11-19 19:53:22.051506',NULL,2,'Q0vyEd3fL0cQBYck8QQuVa7gr1A3','franco leon','francoleon691@gmail.com',false,false,'Student',NULL,NULL,0.00,'44145644',NULL,NULL,NULL,NULL),
	 ('78e994f2-5fd4-41c4-8e2d-b50fc7bb86d5','2022-11-18 19:20:56.401631','2022-11-18 19:22:09.452095',NULL,4,'nQQMzrt9wpefFp2dsy8cRvON5N73','Serena ','scalvorosales@gmail.com',false,false,'Student',NULL,NULL,0.00,'45131223',NULL,NULL,NULL,NULL),
	 ('46d7639e-d09a-4dc6-aeb4-47df6ad480a6','2022-11-20 15:24:23.087808','2022-11-20 15:24:23.087808',NULL,1,'YjhG7dBKUYfgBfd5qHwT8BSubLP2','Eugenia Ruiz','eugeniaruiz01@hotmail.com',false,false,'Student',NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL),
	 ('83b14801-b42a-408f-b2c7-b6563ec86a05','2022-11-18 19:26:48.886616','2022-11-18 19:26:56.769431',NULL,2,'VhYCSwinhrhIbCtzjYovztTMAz53','Agustina','agusdelmonte5@gmail.com',false,false,'Student',NULL,NULL,0.00,'44957031',NULL,NULL,NULL,NULL),
	 ('7edf282e-0055-4375-9518-e91d30e7cb8f','2022-11-20 15:24:22.90733','2022-11-20 15:24:33.639217',NULL,2,'YjhG7dBKUYfgBfd5qHwT8BSubLP2','Eugenia Ruiz','eugeniaruiz01@hotmail.com',false,false,'Student',NULL,NULL,0.00,'44956706',NULL,NULL,NULL,NULL),
	 ('2d523144-379f-451d-ba60-0b16a75b7ebc','2022-11-19 18:58:11.557539','2022-11-19 18:58:22.203973',NULL,2,'75lJ9cDlWXflWfYOqbIvkqcNZgf2','Santiago Gonzalez','santigonzalez3216@gmail.com',false,false,'Student',NULL,NULL,0.00,'42593877',NULL,NULL,NULL,NULL),
	 ('99495fe5-16e6-416f-93ed-6d67a58be933','2022-11-19 19:25:29.838918','2022-11-19 19:25:39.323361',NULL,2,'2Jst7Ul21aXFn1DwUxF8KkJzgQo1','maximo','macufreiz9@gmail.com',false,false,'Student',NULL,NULL,0.00,'45290970',NULL,NULL,NULL,NULL);
INSERT INTO public.users (id,created_at,updated_at,deleted_at,"version",uid,full_name,email,disabled,dark_theme,"type",available_storage,storage_used,balance,dni,available_copies,remaining_copies,campus_id,course_id) VALUES
	 ('18d109a2-7170-46af-920c-af68dfd383dc','2022-11-20 15:37:54.733802','2022-11-20 15:38:04.260417',NULL,2,'CO3cjtVUr7NVI5TbdIBjQgattvW2','Lara','larufissore@hotmail.com',false,false,'Student',NULL,NULL,0.00,'44692615',NULL,NULL,NULL,NULL),
	 ('1496cc56-c696-4441-8e16-ed791c2dcb73','2022-11-19 19:38:16.607463','2022-11-19 19:38:44.859331',NULL,2,'P8lYNap8laOiMATwJYj8tW0VP443','Axel','axelivanparedes@gmail.com',false,false,'Student',NULL,NULL,0.00,'41200468',NULL,NULL,NULL,NULL),
	 ('f339ef7a-c771-47ed-a827-327dcf0830d6','2022-11-19 19:42:10.215914','2022-11-19 19:42:19.583422',NULL,2,'uSU9ZCWaaChibYDdPcEK1UJPmWy1','Facundo','faculazcano@gmail.com',false,false,'Student',NULL,NULL,0.00,'41911910',NULL,NULL,NULL,NULL),
	 ('2847264e-74ba-4c30-a82e-b15523869f1e','2022-11-19 19:41:36.118033','2022-11-19 19:42:35.63486',NULL,2,'fnzN10Q0J2RESeeAu4yds4MIdTz2','Denise Llobet','deni.llobet@gmail.com',false,false,'Student',NULL,NULL,0.00,'41149033',NULL,NULL,NULL,NULL),
	 ('11e63f06-b290-4c77-9ab5-60ba4070fb61','2022-11-19 19:46:42.5464','2022-11-19 19:47:22.779883',NULL,3,'tc2fdDphLbX0Sgitbe31Sqk0fGh1','tomas','tomasfrickmann@gmail.com',false,true,'Student',NULL,NULL,0.00,'44860229',NULL,NULL,NULL,NULL),
	 ('984240fb-b7bf-4f8f-99b4-014de6f5c700','2022-11-19 20:14:30.816507','2022-11-19 20:14:39.722752',NULL,2,'jQvhbEAjq3Pq09mzTaQHSmRmbg52','Leonel','leonellalanne@gmail.com',false,false,'Student',NULL,NULL,0.00,'41078361',NULL,NULL,NULL,NULL),
	 ('18ff1550-3d24-4d4b-abb2-c2453c8cce37','2022-11-19 20:19:26.145474','2022-11-19 20:20:05.967796',NULL,3,'NchyYIZvAfZ9sh2tryr0b2I2jHO2','delfina','delficammarota@gmail.com',false,true,'Student',NULL,NULL,0.00,'44535741',NULL,NULL,NULL,NULL),
	 ('81744dc3-7e91-4627-9d70-749e99e8c3e4','2022-11-19 20:52:40.403495','2022-11-19 20:52:52.190487',NULL,2,'xCg0TENBkGWQmMlHKiwtTiobvzf1','Delfina','delfinaechandi1@icloud.com',false,false,'Student',NULL,NULL,0.00,'44860061',NULL,NULL,NULL,NULL),
	 ('3fcbe4f8-a75f-4c67-a262-e8ba99699e6e','2022-11-19 20:52:51.661361','2022-11-19 20:53:04.182595',NULL,2,'ILZRpjsLuOe2PzOEnl6jNkkqjX63','Carlos Nivio','carlitosniviog@gmail.com',false,false,'Student',NULL,NULL,0.00,'43740681',NULL,NULL,NULL,NULL),
	 ('3b3f1e42-13a5-40a0-abcb-6956f17abc84','2022-11-21 19:43:56.296476','2022-11-21 19:44:48.880626',NULL,2,'A575mLupybMgI33Ioq1NMPBT0h82','Jose','joseph022020@gmail.com',false,false,'Student',NULL,NULL,0.00,'43855894',NULL,NULL,NULL,NULL);
INSERT INTO public.users (id,created_at,updated_at,deleted_at,"version",uid,full_name,email,disabled,dark_theme,"type",available_storage,storage_used,balance,dni,available_copies,remaining_copies,campus_id,course_id) VALUES
	 ('629fb113-fc90-497d-b4ec-fffdcc5ae2ef','2022-11-20 15:50:25.529606','2022-11-20 15:51:30.561961',NULL,4,'ezcgHp02tUVg7AQUVgIJgmsG7l53','Mateo','doljaninmateo@gmail.com',false,false,'Student',NULL,NULL,0.00,'44934943',NULL,NULL,NULL,NULL),
	 ('2620e93e-7a7a-4299-8f17-66e631847fe8','2022-11-20 15:54:58.902008','2022-11-20 15:54:58.902008',NULL,1,'2UEmj9oJ4kcCcehrZNacqbFcQTI2','Angelina','angelinagalarco@gmail.com',false,false,'Student',NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL),
	 ('cddcbfa7-763d-4f67-ab05-4c041b264451','2022-11-20 16:36:33.124776','2022-11-20 16:37:27.435091',NULL,3,'enodGFNzOPVhKzfSSEunNTbhza82','Francisco','franciscostimmler@yahoo.com.ar',false,true,'Student',NULL,NULL,0.00,'42454741',NULL,NULL,NULL,NULL),
	 ('d5a4bfe6-0cb0-4263-8999-51a5cc837322','2022-11-20 16:49:48.459372','2022-11-20 16:51:29.363673',NULL,2,'iwIASYRrfYcV7IA1jHrTWTLMLQ23','Ivan Ratigan','ivanratigan@hotmail.com',false,false,'Student',NULL,NULL,0.00,'43985717',NULL,NULL,NULL,NULL),
	 ('b48a71b6-8d35-48d8-a8d0-f21ffad77b51','2022-11-20 18:36:11.552679','2022-11-20 18:37:12.937975',NULL,2,'OaEsQ8NHCqTwKPv4EE1Rd9hjbSH2','matias','matiasbiasu@gmail.com',false,false,'Student',NULL,NULL,0.00,'55875033',NULL,NULL,NULL,NULL),
	 ('f66bc683-920f-4260-8af9-8fe1851d0df3','2022-11-20 19:01:30.60174','2022-11-20 19:01:44.211611',NULL,2,'9LSk72EzRCNN2zG3iawuRr3l8aI3','sofi ','sofinigro123@gmail.com',false,false,'Student',NULL,NULL,0.00,'43317274',NULL,NULL,NULL,NULL),
	 ('1b763300-2b7a-4414-917a-1761b5862dfa','2022-11-20 19:10:06.255047','2022-11-20 19:10:12.894477',NULL,2,'JG1FUuWgFPfjshJbl8C0S32CfAl1','Lorenzo Sacerdote','lorenzosacerdote@gmail.com',false,false,'Student',NULL,NULL,0.00,'45539109',NULL,NULL,NULL,NULL),
	 ('b127360b-6c7d-446c-8e80-4c31c92c2b02','2022-11-20 19:36:19.216044','2022-11-20 19:36:30.561302',NULL,2,'9fo2fO7GUMNUJSl4vNCwyMCHxPY2','Mia','mia123244@gmail.com',false,false,'Student',NULL,NULL,0.00,'44860507',NULL,NULL,NULL,NULL),
	 ('71ebfc16-d76d-4016-b951-46ad62f77962','2022-11-20 19:44:13.69169','2022-11-20 19:44:27.100353',NULL,2,'gnpd49f8GFQ5TnlSl5UH88LsJPq2','Sol','solchiaradavid@gmail.com',false,false,'Student',NULL,NULL,0.00,'45576694',NULL,NULL,NULL,NULL),
	 ('0b8f8bc0-7cc3-4fed-801d-b3b90c4c5899','2022-11-20 20:07:30.147232','2022-11-20 20:07:41.220637',NULL,2,'WAVOrLhXIIaCfh5osZIQmMrZadm2','Antonella Acconci','acconciantonella664@gmail.com',false,false,'Student',NULL,NULL,0.00,'45576633',NULL,NULL,NULL,NULL);
INSERT INTO public.users (id,created_at,updated_at,deleted_at,"version",uid,full_name,email,disabled,dark_theme,"type",available_storage,storage_used,balance,dni,available_copies,remaining_copies,campus_id,course_id) VALUES
	 ('9532307e-efba-499e-888b-fcc5266c802e','2022-11-20 20:10:46.785437','2022-11-20 20:10:59.39987',NULL,2,'7txce1M7zFOznFFykRB39QwcNej1','Adela','adeedominguez01@gmail.com',false,false,'Student',NULL,NULL,0.00,'43056458',NULL,NULL,NULL,NULL),
	 ('3701432d-b426-44ae-9ad2-2c3d885e9300','2022-11-20 20:13:57.150646','2022-11-20 20:14:05.590094',NULL,2,'37pdBqyGOgNtpgAxKhy8knMVDT22','enzo galvan','enzoggalvan@gmail.com',false,false,'Student',NULL,NULL,0.00,'44831552',NULL,NULL,NULL,NULL),
	 ('b39ea46a-4a7c-43f7-8414-453975527a73','2022-11-20 20:28:20.329558','2022-11-20 20:28:27.759849',NULL,2,'VqA03HKQk7XpXQ21ExThrOgyMwJ2','Joaquin Plastina','joaquin.plastina@gmail.com',false,false,'Student',NULL,NULL,0.00,'44379099',NULL,NULL,NULL,NULL),
	 ('3c5f9a17-c648-4aa3-81d2-2f0e20a412f9','2022-11-20 20:41:18.964335','2022-11-20 20:41:27.901174',NULL,2,'wCl4WjIBtuM2TdEmgwoYbMCgdCz1','Andoni Catalano','andonicatalano1@gmail.com',false,false,'Student',NULL,NULL,0.00,'44562559',NULL,NULL,NULL,NULL),
	 ('9fcbaa08-b3dd-4a78-bdec-da4964cef1fc','2022-11-20 20:53:31.036095','2022-11-20 20:54:52.313549',NULL,2,'wahMSipsV3SJg5dTsbO5Lro06u03','Santiago Preves','santitdm1@gmail.com',false,false,'Student',NULL,NULL,0.00,'44560869',NULL,NULL,NULL,NULL),
	 ('461d0de1-fbc9-413c-95bb-4af57620e585','2022-11-20 21:07:10.208838','2022-11-20 21:07:22.193502',NULL,2,'gaK43teo7UTL5VyA9OEaxhyBnw42','Tomas Helman','helmantomas29@gmail.com',false,false,'Student',NULL,NULL,0.00,'44336566',NULL,NULL,NULL,NULL),
	 ('3d525c87-4f3e-4aad-894b-aeb9773d4bee','2022-11-20 22:02:00.984107','2022-11-20 22:02:10.996667',NULL,2,'rYVnzAD1eBQ7ufbGDHp00bxn1Uf2','Valentin','daurovale0@gmail.com',false,false,'Student',NULL,NULL,0.00,'43864035',NULL,NULL,NULL,NULL),
	 ('a4133b1e-db07-46a1-bf5e-952c8c36a8d3','2022-11-18 18:27:47.048209','2022-11-20 22:46:02.563964',NULL,6,'D9qnToLiA0dl7hD4bgRBnOHo4Qe2','Maria Bustamante Zotti','maribustamantezotti@gmail.com',false,false,'Student',NULL,NULL,0.00,'45905581',NULL,NULL,NULL,NULL),
	 ('734f7e64-5d5e-4ca0-a649-d01a6e9a3e66','2022-11-20 22:57:01.742087','2022-11-20 22:57:26.845187',NULL,2,'buJ735LIJ8UPKVU53vNYzPstYyJ3','lourdes luna','lourdesluna292@gmail.com',false,false,'Student',NULL,NULL,0.00,'44858778',NULL,NULL,NULL,NULL),
	 ('c34d0ef5-4c66-4b17-8a90-b16c800354e6','2022-11-20 23:03:38.970266','2022-11-20 23:03:38.970266',NULL,1,'Hc9RxK6OEJWXVzh8FqlIoDGN6nr2','Lourdes luna ','lourdesluna292@hotmail.com',false,false,'Student',NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL);
INSERT INTO public.users (id,created_at,updated_at,deleted_at,"version",uid,full_name,email,disabled,dark_theme,"type",available_storage,storage_used,balance,dni,available_copies,remaining_copies,campus_id,course_id) VALUES
	 ('e5500087-2f75-431a-983e-c43f6bb41acd','2022-11-20 23:04:39.863682','2022-11-20 23:05:03.981364',NULL,2,'c6oosNbBekV72k2mI63JKQ28Mhj1','Ramiro Jozami','ramajozami@gmail.com',false,false,'Student',NULL,NULL,0.00,'44859597',NULL,NULL,NULL,NULL),
	 ('d7ba00cd-e37e-48ec-80f2-72013da4f88e','2022-11-20 23:34:45.377314','2022-11-20 23:35:07.038808',NULL,2,'cCt36Ne1pNOGj2cmOd7KswebnY92','delfina','delfinagarciacurto@gmail.com',false,false,'Student',NULL,NULL,0.00,'44861278',NULL,NULL,NULL,NULL),
	 ('65381e89-d9d4-4bfe-9e2f-eff89f595d32','2022-11-20 23:48:39.131421','2022-11-20 23:48:58.053991',NULL,2,'fNTxZWVTJqPindoZg5xfIPzbiHl1','Denise','sanchezdenise1998@gmail.com',false,false,'Student',NULL,NULL,0.00,'41333587',NULL,NULL,NULL,NULL),
	 ('e18bf579-b15b-47ac-a9b2-632f1d79c3c8','2022-11-21 00:06:56.201889','2022-11-21 00:07:10.459376',NULL,2,'tgrhKT1FUJck7yhIOcGPDxiUoOl2','Sofia','sofia.f47@hotmail.com',false,false,'Student',NULL,NULL,0.00,'43819451',NULL,NULL,NULL,NULL),
	 ('1daa6d5f-f767-47c8-82d9-1b7750af3303','2022-11-21 00:41:20.971041','2022-11-21 00:41:29.141703',NULL,2,'ysYvKeA8pIPByo12UzdlHgPyulx1','Lucas Trentin','luckytrentin@gmail.com',false,false,'Student',NULL,NULL,0.00,'44169367',NULL,NULL,NULL,NULL),
	 ('dfe022cc-d219-453a-b18a-17f83bcbfdba','2022-11-21 00:51:33.605111','2022-11-21 00:51:45.123772',NULL,2,'vOJsZ7yV7ONpj3gvoJwkfQRo6Uj1','Iñaki Agrelo','inakiagrelo@gmail.com',false,false,'Student',NULL,NULL,0.00,'44335627',NULL,NULL,NULL,NULL),
	 ('b7b319a9-b557-451a-b246-f8269089ac64','2022-11-21 00:52:41.409694','2022-11-21 00:52:51.256054',NULL,2,'0CdmZQo7L0hMJnMD0fwdUR6gnmi2','Manuel','manuelmoralessoler@gmail.com',false,false,'Student',NULL,NULL,0.00,'44335772',NULL,NULL,NULL,NULL),
	 ('d773af8a-8208-46bd-a095-90ff937d6121','2022-11-21 00:48:00.211242','2022-11-21 01:05:22.944074',NULL,3,'AYxZLKxnmbT5YloKfIR1wc6Aay53','Magali','maga_09@live.com.ar',false,true,'Student',NULL,NULL,0.00,'39834617',NULL,NULL,NULL,NULL),
	 ('5301c54d-4ed0-4db2-b9c9-bf9e857aab79','2022-11-21 01:33:12.430051','2022-11-21 01:34:40.303544',NULL,2,'s3yJNx6SJkdR2lsH8dtkyZc6g9L2','Camila','camiilaa99pz@gmail.com',false,false,'Student',NULL,NULL,0.00,'1111111111',NULL,NULL,NULL,NULL),
	 ('f1aa6195-5e6f-4871-b8cb-cf18101e60c5','2022-11-21 03:18:17.367824','2022-11-21 03:18:57.071524',NULL,2,'PiSziOEmwBQjZcofGFz6IeWM4O92','Lozano Larralde Mateo','lozamateo09@gmail.com',false,false,'Student',NULL,NULL,0.00,'44927836',NULL,NULL,NULL,NULL);
INSERT INTO public.users (id,created_at,updated_at,deleted_at,"version",uid,full_name,email,disabled,dark_theme,"type",available_storage,storage_used,balance,dni,available_copies,remaining_copies,campus_id,course_id) VALUES
	 ('169df1f7-c277-4599-bbe4-69a43b2c8a0f','2022-11-21 03:45:17.828186','2022-11-21 03:45:30.513199',NULL,2,'NpNS4CTTxHXolQI4lATA7xTGBhT2','Francisco Filippetto','franfilippetto@gmail.com',false,false,'Student',NULL,NULL,0.00,'45993559',NULL,NULL,NULL,NULL),
	 ('ff5d18bc-acad-4674-848f-20a0bfa0c2f8','2022-11-21 10:28:33.947115','2022-11-21 10:28:33.947115',NULL,1,'hpydfj6PaqTTUXiY3LtR7LYoVcv1','Alexander','virot60198@sopulit.com',false,false,'Student',NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL),
	 ('de069c31-a684-43f2-a51e-ca374c1c5a90','2022-11-21 10:28:33.928598','2022-11-21 10:36:41.017427',NULL,12,'hpydfj6PaqTTUXiY3LtR7LYoVcv1','Alexander','virot60198@sopulit.com',false,false,'Student',NULL,NULL,0.00,'assdfgbnh',NULL,NULL,NULL,NULL),
	 ('3fb8a158-bf8a-4102-b553-27e010aabc46','2022-11-21 11:03:32.602392','2022-11-21 11:03:43.176111',NULL,2,'hka8PCg1dvdf0w029t97Bequ5VD2','Nico','nicolasmgazzoli@gmail.com',false,false,'Student',NULL,NULL,0.00,'44858596',NULL,NULL,NULL,NULL),
	 ('1d1ecdc2-08f4-49fd-bc43-40d011c39535','2022-11-21 11:55:33.229825','2022-11-21 11:55:57.246548',NULL,2,'uZLO5tJP02gaG50b2TJ74G5WJ253','Catalina','kattasuarez2000@gmail.com',false,false,'Student',NULL,NULL,0.00,'42827147',NULL,NULL,NULL,NULL),
	 ('6d0abe47-3ecb-4723-ae9e-4ca0a3a5a9fe','2022-11-21 13:10:37.416298','2022-11-21 13:10:55.912025',NULL,2,'pUpKwl9G6iU7ZJCmC6jwokgdBJg1','Fausto','faustohernando176@gmail.com',false,false,'Student',NULL,NULL,0.00,'43797171',NULL,NULL,NULL,NULL),
	 ('55a8d295-2668-4480-ba2b-894ebcd0acae','2022-11-21 13:18:14.058793','2022-11-21 13:21:37.470783',NULL,3,'M6NFgXdREUcThF86q1Nn9IJ9Nnu1','Tomas Sacadura','tomysacadura@yahoo.com.ar',false,true,'Student',NULL,NULL,0.00,'42398456',NULL,NULL,NULL,NULL),
	 ('17bb8674-52e4-4a7f-92d5-e2ac5b02861a','2022-11-21 13:49:26.982599','2022-11-21 13:50:02.38215',NULL,2,'qRHzikJ04DekEmksfmB6vt90SQH3','Nicolas','nicolasruau7@gmail.com',false,false,'Student',NULL,NULL,0.00,'40456277',NULL,NULL,NULL,NULL),
	 ('d5267aa3-03bb-480c-8b1e-d8944a22efc4','2022-11-21 13:51:34.21314','2022-11-21 13:52:17.986517',NULL,2,'quON2e4IqKVcgSnF5KtmW4Dhr5h1','Magdalena Antonacci','antonaccimagdalena@gmail.com',false,false,'Student',NULL,NULL,0.00,'44692568',NULL,NULL,NULL,NULL),
	 ('32533954-2223-402b-b6ee-10062afdf341','2022-11-21 13:54:44.479673','2022-11-21 13:55:00.432915',NULL,2,'EDjBXF8nqudS0auTONymsAG48i82','Carolina Rolandi','carolinarolandibellometti@gmail.com',false,false,'Student',NULL,NULL,0.00,'45292915',NULL,NULL,NULL,NULL);
INSERT INTO public.users (id,created_at,updated_at,deleted_at,"version",uid,full_name,email,disabled,dark_theme,"type",available_storage,storage_used,balance,dni,available_copies,remaining_copies,campus_id,course_id) VALUES
	 ('b4ee3bfe-c09c-444c-90f8-29a340581035','2022-11-21 13:59:14.2303','2022-11-21 13:59:25.339288',NULL,2,'KgKMXHY4xAWjr0B4VIWsolICe4c2','Lucas Enzo','lucascapraarg@gmail.com',false,false,'Student',NULL,NULL,0.00,'43456750',NULL,NULL,NULL,NULL),
	 ('5f4a4d20-c723-4ddc-917f-d7c085c9d608','2022-11-21 14:54:37.805111','2022-11-21 14:54:37.805111',NULL,1,'dbV06KhdKqZljd5qygs6BxxKlQx1','Ramiro Varela Muñoz','ramiv2000@gmail.com',false,false,'Student',NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL),
	 ('d9468a8b-75cc-453d-bcc9-a800d7debc54','2022-11-21 14:54:37.797571','2022-11-21 14:54:46.890677',NULL,2,'dbV06KhdKqZljd5qygs6BxxKlQx1','Ramiro Varela Muñoz','ramiv2000@gmail.com',false,false,'Student',NULL,NULL,0.00,'43017833',NULL,NULL,NULL,NULL),
	 ('b12799cd-c92a-4460-bcfc-2d005ec793da','2022-11-21 13:30:20.132326','2022-11-21 14:54:47.254901',NULL,4,'y5mIyw4TIdQuXic79I1TnoQxF2E2','Ignacio Sanchez Wakuluk','ignacio.wakuluk@gmail.com',false,false,'Student',NULL,NULL,0.00,'43523561',NULL,NULL,NULL,NULL),
	 ('9028bc46-ba1c-4328-8349-f756159b9851','2022-11-21 15:04:23.452761','2022-11-21 15:04:37.098174',NULL,2,'xXwcigi3dJdvAvS1Brdfy4SkTLW2','Julieta','juliietarey@gmail.com',false,false,'Student',NULL,NULL,0.00,'44860359',NULL,NULL,NULL,NULL),
	 ('54ea53a1-cbb5-4411-94fc-3e736a835636','2022-11-21 15:27:05.045297','2022-11-21 15:27:19.088405',NULL,2,'LoPyvHtEXyPlsSJdijmJa1iYP3F2','lucía','lucam8av@gmail.com',false,false,'Student',NULL,NULL,0.00,'45500262',NULL,NULL,NULL,NULL),
	 ('6a1e1f0d-3f2a-44bc-a0e5-f6d89e0321dd','2022-11-21 16:23:47.115231','2022-11-21 16:23:56.927088',NULL,2,'26yjPoeCamTVEtLPrb68d3q0QYw2','Luana Miguez','luanammiguez@gmail.com',false,false,'Student',NULL,NULL,0.00,'45291034',NULL,NULL,NULL,NULL),
	 ('c45c3d96-2c8d-4d5a-81a4-8a2210951ebb','2022-11-21 16:43:32.923206','2022-11-21 16:43:58.136791',NULL,2,'SVnLY7fv24cKjSI2fEMeQpdH9UL2','Lorenzo','lpapasodaro1@gmail.com',false,false,'Student',NULL,NULL,0.00,'44335770',NULL,NULL,NULL,NULL),
	 ('df15dd20-05f6-44d6-95f0-d3d66d94192d','2022-11-21 16:46:11.116583','2022-11-21 16:46:22.78978',NULL,2,'hmW9iDb0F0TdQvkD1Cn9gfBG5WV2','marco','marcoromairone31415@gmail.com',false,false,'Student',NULL,NULL,0.00,'44858968',NULL,NULL,NULL,NULL),
	 ('46b167f4-c2a0-47c1-8270-5c0996608070','2022-11-21 19:26:06.512193','2022-11-21 19:26:15.647743',NULL,2,'XH2N0oTBR6bOXdN9vRhF0EezWOT2','Cristian Tapia','cristian.tapia@alumnos.fi.mdp.edu.ar',false,false,'Student',NULL,NULL,0.00,'43905530',NULL,NULL,NULL,NULL);
INSERT INTO public.users (id,created_at,updated_at,deleted_at,"version",uid,full_name,email,disabled,dark_theme,"type",available_storage,storage_used,balance,dni,available_copies,remaining_copies,campus_id,course_id) VALUES
	 ('88c59ff6-ac59-4251-9b0c-e9be049ae8a8','2022-11-21 16:49:54.082523','2022-11-21 16:50:08.8474',NULL,2,'hhwpPU8vHbRyXPyht32HzYVBlx53','juan martin costa','juanmartincosta81@gmail.com',false,false,'Student',NULL,NULL,0.00,'44560881',NULL,NULL,NULL,NULL),
	 ('67a57fd8-2407-4009-9bd9-02d0baa64686','2022-11-21 17:23:55.774099','2022-11-21 17:26:54.537865',NULL,4,'EsXK06R9bVShlLvlLlcq4AY0uyh1','Natalia ','nataliacorrearacing@gmail.com',false,false,'Student',NULL,NULL,0.00,'41854303',NULL,NULL,NULL,NULL),
	 ('4a653fbb-b6e2-4ac8-9e84-d5666ff7e76a','2022-11-21 19:58:39.916398','2022-11-21 19:59:58.620869',NULL,3,'aEs6Eb1N1Ie9Ka3QIYCSClyvJOh1','Natalie Ornella Borges','natalieborges2002@gmail.com',false,true,'Student',NULL,NULL,0.00,'43855032',NULL,NULL,NULL,NULL),
	 ('e9cb51bd-8a07-41c1-ae97-f078e0c3c134','2022-11-21 18:04:29.500076','2022-11-21 18:05:11.403461',NULL,2,'XHHWVUgNXldQThq1g7VIU65RqNp1','Juan Pablo Teruggi','jp-ter@hotmail.com',false,false,'Student',NULL,NULL,0.00,'42569169',NULL,NULL,NULL,NULL),
	 ('a0b40b1e-aae2-430e-8ef3-9a4bac40a77a','2022-11-21 20:18:38.935217','2022-11-21 20:18:55.643975',NULL,2,'2W5AzTvNtPOWT1TYhrbDZyvwXdu1','Aylen','aylenrgaudini@gmail.com',false,false,'Student',NULL,NULL,0.00,'44861320',NULL,NULL,NULL,NULL),
	 ('3d0b06df-fec6-4881-bccf-b1f35db63b1f','2022-11-21 18:39:15.703447','2022-11-21 18:39:52.99102',NULL,2,'8SRCaq0dO6bSC5PMDshe5zQ7Hxo1','Rocio Altamiranda','rocioaltamirandac@gmail.com',false,false,'Student',NULL,NULL,0.00,'41458558',NULL,NULL,NULL,NULL),
	 ('f966f1ba-73b4-4c40-a6c5-dc0d7e9b93ba','2022-11-21 18:47:59.420573','2022-11-21 18:48:10.091251',NULL,2,'Ap6SgLxGvpUgK6n1cafLmFveDK83','lautaro','lautaroarias02@gmail.com',false,false,'Student',NULL,NULL,0.00,'44265003',NULL,NULL,NULL,NULL),
	 ('3c2bdbc2-1dff-4ccd-b900-59a0caf7aca7','2022-11-21 20:38:57.956479','2022-11-21 20:39:11.183921',NULL,2,'C5u4y2pWBJY9MbPcAe4EASFruZz2','Hector Emanuel Villalba','emanuel.villalba143@gmail.com',false,false,'Student',NULL,NULL,0.00,'44145423',NULL,NULL,NULL,NULL),
	 ('902d0b34-4a42-49ff-939d-9598f0bb9912','2022-11-21 18:51:51.577171','2022-11-21 18:52:05.418994',NULL,2,'c3GFlhOQqXeJbMjDyXfc8zQ53tE2','María Agostina Rodríguez','mariaagostinarodriguezsala@gmail.com',false,false,'Student',NULL,NULL,0.00,'44459976',NULL,NULL,NULL,NULL),
	 ('84562d50-757f-4b06-88c3-1804fc8bfd24','2022-11-21 21:05:10.678116','2022-11-21 21:05:20.49557',NULL,2,'RRuisGlH3NVV14DwEOdi5fjItqu2','Valentina ','derosavalenn@gmail.com',false,false,'Student',NULL,NULL,0.00,'43457050',NULL,NULL,NULL,NULL);
INSERT INTO public.users (id,created_at,updated_at,deleted_at,"version",uid,full_name,email,disabled,dark_theme,"type",available_storage,storage_used,balance,dni,available_copies,remaining_copies,campus_id,course_id) VALUES
	 ('ff909f1f-b354-44c9-be0d-b5b44a526ae0','2022-11-21 18:56:05.825241','2022-11-21 18:56:35.826179',NULL,4,'48ZsOUrwcdUP2uRcve6D07SgXKk2','Fermín','fercuvi2004@gmail.com',false,false,'Student',NULL,NULL,0.00,'45621775',NULL,NULL,NULL,NULL),
	 ('4e666c79-75c3-45c7-8d4c-4510700fcc4a','2022-11-21 21:08:57.191951','2022-11-21 21:14:32.228099',NULL,2,'WAelD1a0oLWCNGlxbVhkAvCGCE72','juan','juanelezca@gmail.com',false,false,'Student',NULL,NULL,0.00,'41926094',NULL,NULL,NULL,NULL),
	 ('73269de9-e967-4916-8eea-7cf8efa179f2','2022-11-21 19:07:30.212371','2022-11-21 19:07:38.268585',NULL,2,'uS871NLITGXHPVkpI3nqwSKCNxk2','alejo giorgi','giorgialejo@gmail.com',false,false,'Student',NULL,NULL,0.00,'46951583',NULL,NULL,NULL,NULL),
	 ('bc04dd6c-3130-44a5-9e5a-75e17401e79b','2022-11-21 19:07:27.866935','2022-11-21 19:07:38.284543',NULL,2,'sisnO9EqYkezCxZEbLQgUSIwRXZ2','Julian Alvarez','julianftw1999@gmail.com',false,false,'Student',NULL,NULL,0.00,'42282383',NULL,NULL,NULL,NULL),
	 ('1c9c978f-6ca8-42c0-8514-5508da2a3e90','2022-11-21 19:11:12.28383','2022-11-21 19:11:27.492044',NULL,2,'R2ZzQslV3vP30eV8gRSSyeJhCov2','Lucia','luciamassolo04@gmail.com',false,false,'Student',NULL,NULL,0.00,'45905453',NULL,NULL,NULL,NULL),
	 ('20149a8c-448a-4c07-bcd5-79a88853d006','2022-11-21 21:33:23.650754','2022-11-21 21:33:34.064976',NULL,2,'3BZxMyRcCpemLEMNR5rWu580c9z1','Francisco Giorgi Games','frangiorgi10@gmail.com',false,false,'Student',NULL,NULL,0.00,'43017871',NULL,NULL,NULL,NULL),
	 ('b96fd8ba-c1ae-46ac-ab41-acdacf22812e','2022-11-21 21:41:55.160375','2022-11-21 21:42:02.901952',NULL,2,'7RPo1sksC2dLu1sucmIZx19b7Tm1','gaston','aristizabalgaston@gmail.com',false,false,'Student',NULL,NULL,0.00,'39762923',NULL,NULL,NULL,NULL),
	 ('365b166c-01f6-42d6-9e54-0f86a856388f','2022-11-21 21:56:56.786849','2022-11-21 21:57:10.224097',NULL,2,'i7NvdsPTBUYgVJXejpHofmrCw8e2','Lucas','lucasnavarrodufur@gmail.com',false,false,'Student',NULL,NULL,0.00,'40064083',NULL,NULL,NULL,NULL),
	 ('64e0a8d4-fdb3-437e-9792-c2043c06226a','2022-11-21 22:06:09.352744','2022-11-21 22:13:51.957188',NULL,3,'y4tZuYj9kMUAjTpNgMfssuoWH293','Julián Mellado','julianmellado@gmail.com',false,false,'Student',NULL,NULL,0.00,'43784412',NULL,NULL,NULL,NULL),
	 ('50269a6b-0ce7-4729-b0dc-3ad6f73f8727','2022-11-21 22:25:59.283268','2022-11-21 22:26:27.032813',NULL,2,'GyzRHIXnd8TQnmACeCCSnPHCaKB2','Guadalupe Garcia','guadagar00jaz@gmail.com',false,false,'Student',NULL,NULL,0.00,'42593984',NULL,NULL,NULL,NULL);
INSERT INTO public.users (id,created_at,updated_at,deleted_at,"version",uid,full_name,email,disabled,dark_theme,"type",available_storage,storage_used,balance,dni,available_copies,remaining_copies,campus_id,course_id) VALUES
	 ('6be1d31b-172a-4e48-baf2-ef951de49116','2022-11-21 22:30:56.237789','2022-11-21 22:31:24.503383',NULL,2,'dS5Lk46SuOcZxZdoCOG4X9OC8gp2','Bárbara Loscalzo','barbaraloscalzobianchi@gmail.com',false,false,'Student',NULL,NULL,0.00,'43986103',NULL,NULL,NULL,NULL),
	 ('3f36aca9-3669-470b-932c-ce0851311b1b','2022-11-21 22:33:55.749481','2022-11-21 22:33:55.749481',NULL,1,'WkWebKjIA4NZECAGxheCAZKohEW2','Luisina','oliverluisina@gmail.com',false,false,'Student',NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL),
	 ('0104df6d-a9da-433b-9cea-61b3cb64ee92','2022-11-17 17:04:53.872815','2022-11-21 22:35:54.42909',NULL,13,'9QWgOL1n25Q6jm9eNjzlyxgS5ol1','Veniero Gallini','galliniveniero@gmail.com',false,false,'Student',NULL,NULL,90.00,'46029970',NULL,NULL,NULL,NULL),
	 ('f3779b66-3c86-4f52-be77-7e48c7b2a675','2022-11-21 22:37:59.396981','2022-11-21 22:44:57.911209',NULL,2,'BhMDHDpYJ3S4JLTobE3CrnSnMgq2','juan','hbpkwoai@sharklasers.com',false,false,'Student',NULL,NULL,0.00,'44456789',NULL,NULL,NULL,NULL),
	 ('1169ee33-9494-4a7a-9f2d-fad5a9f78df3','2022-11-21 23:26:20.159544','2022-11-21 23:26:31.015398',NULL,2,'3ptw12zyQKfbCXo5iTNod8akYY43','brisa','cordobamartina39@gmail.com',false,false,'Student',NULL,NULL,0.00,'43056471',NULL,NULL,NULL,NULL),
	 ('678b837f-3080-4a12-ab17-f3d4324c6aa0','2022-11-21 23:30:07.536874','2022-11-21 23:30:17.412847',NULL,2,'NfA806E1Vhdh1CJVMz4B2BGZVTI3','matias toraño','matiasto65@gmail.com',false,false,'Student',NULL,NULL,0.00,'42392243',NULL,NULL,NULL,NULL),
	 ('be4e6c02-6e54-4f2e-9e31-d25e23694918','2022-11-21 23:39:12.894761','2022-11-21 23:39:42.288349',NULL,2,'2iRKYddrtEe2WpHyXkPaAUcbEji1','miranda','mirubattaglia@gmail.com',false,false,'Student',NULL,NULL,0.00,'45131251',NULL,NULL,NULL,NULL),
	 ('ae4fb078-9a2c-438c-aac4-0c5354f3c9b5','2022-11-22 02:26:38.053129','2022-11-22 02:26:56.156265',NULL,2,'9uefiVP7oEQV1y7SA8piKDUc9V63','Sofia','sofiasawczuka@gmail.com',false,false,'Student',NULL,NULL,0.00,'43835475',NULL,NULL,NULL,NULL),
	 ('b7170096-7b22-415a-9060-d3843cb35937','2022-11-22 02:31:07.491554','2022-11-22 02:31:16.494132',NULL,2,'9V60dKgLKyaJtFD2UDzS6CXdSYv1','Mateo Pose','mateoposeoo7@gmail.com',false,false,'Student',NULL,NULL,0.00,'45400134',NULL,NULL,NULL,NULL),
	 ('0d0be707-3aca-40e4-87dc-c96dcd74998a','2022-11-22 02:52:42.589311','2022-11-22 02:53:13.357077',NULL,2,'woFKB5TLgTNTcgIn3gndDN50aTa2','Ramiro Delucis','ramiayco14@gmail.com',false,false,'Student',NULL,NULL,0.00,'41669270',NULL,NULL,NULL,NULL);
INSERT INTO public.users (id,created_at,updated_at,deleted_at,"version",uid,full_name,email,disabled,dark_theme,"type",available_storage,storage_used,balance,dni,available_copies,remaining_copies,campus_id,course_id) VALUES
	 ('02ff0bf0-71a2-4973-bcb9-5ed059b905fc','2022-11-22 03:39:47.429018','2022-11-22 03:39:47.429018',NULL,1,'aDFGHbaS4bSLxCDxGflpGaNRxln1','Ludmila ','coronelludmila08@gmail.com',false,false,'Student',NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL),
	 ('2ac5d0c3-e6d0-4240-a0fc-f9010006df57','2022-11-22 03:39:47.420545','2022-11-22 03:42:30.061234',NULL,7,'aDFGHbaS4bSLxCDxGflpGaNRxln1','Ludmila ','coronelludmila08@gmail.com',false,false,'Student',NULL,NULL,0.00,'43855799',NULL,NULL,NULL,NULL),
	 ('a01f7217-ca6e-4078-a033-9bf5c1f9e7e4','2022-11-22 04:26:29.775643','2022-11-22 04:26:38.768072',NULL,2,'ULpQBFcSt6QM80djwCr9nS4xuZD2','lucas','lucassosaa2004@gmail.com',false,false,'Student',NULL,NULL,0.00,'45923155',NULL,NULL,NULL,NULL),
	 ('54582729-10ac-4ee4-9dce-eec90d16759d','2022-11-22 10:14:39.322968','2022-11-22 10:14:49.518636',NULL,2,'BbpTmEWKI8YI9jESX5Z5xpVTMmf2','Denise ','denisebehar2012@hotmail.com',false,false,'Student',NULL,NULL,0.00,'43317318',NULL,NULL,NULL,NULL),
	 ('540d2bff-3d51-4b67-8929-38afbe5606c5','2022-11-22 10:16:16.381166','2022-11-22 10:16:29.163672',NULL,2,'ZeFddcHk16URPxhKD3XOCl4bitp1','Adrian Perretta','adrianperretta@outlook.com',false,false,'Student',NULL,NULL,0.00,'44861545',NULL,NULL,NULL,NULL),
	 ('90c7b18a-35c2-4911-b446-db0e61cc003a','2022-11-22 10:56:04.885244','2022-11-22 10:56:36.988795',NULL,3,'AajabJr7VOSyc8040dVpyJZmm4v1','Lucas','lucas.pagliaro1@gmail.com',false,true,'Student',NULL,NULL,0.00,'45421408',NULL,NULL,NULL,NULL),
	 ('0733125f-3e5e-4c72-845d-cbda05aba9a2','2022-11-22 12:01:24.309466','2022-11-22 12:01:43.915852',NULL,2,'F6sFhGh0AcUUmqP9jGrlNmFYLuB3','Ramiro','ramiro.rossi97@hotmail.com',false,false,'Student',NULL,NULL,0.00,'40395312',NULL,NULL,NULL,NULL),
	 ('6669da81-a900-4428-91ee-57f00d61ee5b','2022-11-22 12:56:45.766581','2022-11-22 12:56:57.347724',NULL,2,'GaXoa7IdnabUnmNHwlHWcb7mPW03','lautaro','lautigoni12@gmail.com',false,false,'Student',NULL,NULL,0.00,'44460099',NULL,NULL,NULL,NULL),
	 ('82e16106-b72d-4375-a1b8-130913b46047','2022-11-22 13:03:15.118733','2022-11-22 13:03:25.151559',NULL,2,'zDx4Tae2gsQod7McB10PgDGPKIw1','Mariano Andrés Horianski','marianohorianski@gmail.com',false,false,'Student',NULL,NULL,0.00,'44336097',NULL,NULL,NULL,NULL),
	 ('b38026ab-0b91-482a-99f5-7d394f2a09c8','2022-11-22 14:11:35.171486','2022-11-22 14:11:49.72136',NULL,2,'CQCExbj4VHXZQ5If7x5SLyEazeA3','Agustin Angelini','agusangelini@live.com',false,false,'Student',NULL,NULL,0.00,'43740865',NULL,NULL,NULL,NULL);
INSERT INTO public.users (id,created_at,updated_at,deleted_at,"version",uid,full_name,email,disabled,dark_theme,"type",available_storage,storage_used,balance,dni,available_copies,remaining_copies,campus_id,course_id) VALUES
	 ('b93715a2-2fb3-4912-91b4-5bd03161c2cd','2022-11-22 16:09:05.21017','2022-11-22 16:09:37.031967',NULL,2,'gxvGK4B82OVN6Ne91yMcB8lt4VJ3','Memi La Grasta','emilialagrasta@gmail.com',false,false,'Student',NULL,NULL,0.00,'44692754',NULL,NULL,NULL,NULL),
	 ('006cf310-d623-496e-9cef-fb07e8613fc2','2022-11-22 17:35:41.065882','2022-11-22 17:35:53.437709',NULL,2,'imQubLzTNQWFvFLab8H4AYKmDYr2','Celeste','celesteasensio002@gmail.com',false,false,'Student',NULL,NULL,0.00,'44264760',NULL,NULL,NULL,NULL),
	 ('15024dfb-e6b3-44e9-94f7-415c4b192028','2022-11-22 18:02:42.216693','2022-11-22 18:02:52.912384',NULL,2,'1Smr3g9YrIdlcNaGzfAaGHMxHfF2','Martin','martinpatriarca@gmail.com',false,false,'Student',NULL,NULL,0.00,'44264729',NULL,NULL,NULL,NULL),
	 ('a2687ae4-17fd-4782-9987-ff683256818c','2022-11-22 18:40:19.567188','2022-11-22 18:40:19.567188',NULL,1,'MX6yXnJjFrZvzN10ez8XFuAz2Mg1','Antonia calvo','antocalvo253@gmail.com',false,false,'Student',NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL),
	 ('9bcaf41c-bc92-4619-a38d-1bf083119244','2022-11-22 18:40:19.450591','2022-11-22 18:41:02.633271',NULL,4,'MX6yXnJjFrZvzN10ez8XFuAz2Mg1','Antonia calvo','antocalvo253@gmail.com',false,false,'Student',NULL,NULL,0.00,'44860973',NULL,NULL,NULL,NULL),
	 ('1248a664-3f65-497d-8f37-1d66d8129761','2022-11-22 18:47:42.517568','2022-11-22 18:48:05.193602',NULL,2,'iXYhyDw8NKQmudoFV5XajSBMQO12','Felipe Gonzalez','feligonzalez888@gmail.com',false,false,'Student',NULL,NULL,0.00,'44377903',NULL,NULL,NULL,NULL),
	 ('35d89a37-f998-4da4-83a8-0c80167618ed','2022-11-22 19:24:09.321792','2022-11-22 19:25:29.244432',NULL,3,'WRZTKftNzYhiwGh4NDvxgfphnMO2','Ian Hein','ianhein50@gmail.com',false,false,'Student',NULL,NULL,0.00,'41773003',NULL,NULL,NULL,NULL),
	 ('becac8e9-af69-4cae-893c-6426e9e45b56','2022-11-22 20:01:07.163159','2022-11-22 20:01:07.163159',NULL,1,'980WWOzf1GMAfaypQPOeWStSgoi2','Ramiro Tremsal','ramatremsal@gmail.com',false,false,'Student',NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL),
	 ('383e7e48-43c7-4a70-b969-be27fbf8dc91','2022-11-22 20:01:07.130437','2022-11-22 20:05:33.623588',NULL,11,'980WWOzf1GMAfaypQPOeWStSgoi2','Ramiro Tremsal','ramatremsal@gmail.com',false,false,'Student',NULL,NULL,0.00,'44242444',NULL,NULL,NULL,NULL),
	 ('8ff2748d-71c7-4119-8a95-f55609c6bef7','2022-11-20 20:19:07.355964','2022-11-22 20:07:14.298784',NULL,2,'Vac169NuEsaW9Vtp6c8wYlWWW6u1','Agostina','agosbrunatti7@gmail.com',false,false,'Student',NULL,NULL,0.00,'44956896',NULL,NULL,NULL,NULL);
INSERT INTO public.users (id,created_at,updated_at,deleted_at,"version",uid,full_name,email,disabled,dark_theme,"type",available_storage,storage_used,balance,dni,available_copies,remaining_copies,campus_id,course_id) VALUES
	 ('01de438c-c163-446a-80ca-14cc8044ea82','2022-11-22 20:19:02.669475','2022-11-22 20:19:14.895396',NULL,2,'nk4IQN6xaKalqzVLm8d5pMnFh6n2','Marisolpe94@gmail.com','marisolpe94@gmail.com',false,false,'Student',NULL,NULL,0.00,'38395462',NULL,NULL,NULL,NULL),
	 ('d70e3fc4-e2e4-4dc2-a7b1-a8db6a282046','2022-11-22 20:20:54.044537','2022-11-22 20:21:04.235364',NULL,2,'AqPFCfHQXyTpVPIsxWdmKHhkgoK2','Facundo','facucastellano@gmail.com',false,false,'Student',NULL,NULL,0.00,'43017700',NULL,NULL,NULL,NULL),
	 ('63e80179-1354-4f33-a6c7-59feeab4c51b','2022-11-22 20:43:03.61413','2022-11-22 20:43:14.144614',NULL,2,'Rdbqc0KxyHdnNjdv7pBwIicsrWY2','Ivan','ivan2004once@gmail.com',false,false,'Student',NULL,NULL,0.00,'45400187',NULL,NULL,NULL,NULL),
	 ('13520662-3064-409f-9472-98b806bfd22b','2022-11-22 20:53:09.891075','2022-11-22 20:53:29.344026',NULL,2,'GvxB250OixaGvtRygZ5fnQRsucp1','tomas candotto','candottomartin@gmail.com',false,false,'Student',NULL,NULL,0.00,'44859956',NULL,NULL,NULL,NULL),
	 ('67010874-6d18-4c2e-af32-7c8a9ee66128','2022-11-22 21:46:52.82563','2022-11-22 21:47:04.347162',NULL,2,'DemV2zKyd9XasnDyFWvY8gylNEX2','Julian Maxit','juliimaxit@gmail.com',false,false,'Student',NULL,NULL,0.00,'42778602',NULL,NULL,NULL,NULL),
	 ('f7432ca0-14d2-4162-84c7-7cdf98fc54b6','2022-11-22 21:48:16.705749','2022-11-22 21:48:26.552264',NULL,2,'In2ZX3yDB8MrPT7SHkFjdRNg46e2','Victoria Troncoso','victoriattroncoso@gmail.com',false,false,'Student',NULL,NULL,0.00,'42963835',NULL,NULL,NULL,NULL);
