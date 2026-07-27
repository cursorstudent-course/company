BEGIN;

INSERT INTO products VALUES
 ('K12','Электронный блок К-12','critical_component'),
 ('ASM-100','Сборочный узел стандарт','finished'),
 ('ASM-200','Сборочный узел premium','finished');

INSERT INTO warehouse_bins VALUES
 ('WH-MAIN','Основной склад'),
 ('WH-LINE','Буфер линии');

INSERT INTO vendors VALUES
 ('V-NORD','NordSupply AB','SE','K12_electronics',TRUE),
 ('V-GLOB','GlobalParts Ltd','CN','mechanics',TRUE),
 ('V-EURO','EuroComponents GmbH','DE','K12_electronics',FALSE),
 ('V-ALLY','ООО Альянс-Сервис','RU','consulting_services',TRUE);

INSERT INTO customers VALUES
 ('C-URAL','УралСтрой','7701001001','E008','key',45),
 ('C-SIB','СибМонтаж','5402002002','E008','key',60),
 ('C-TECH','ТехноЛиния','7803003003','E009','standard',35),
 ('C-ALFA','ООО Альфа',NULL,'E008','standard',30),
 ('C-BETA','ООО Бета','5005005005','E010','standard',30),
 ('C-VOLGA','ВолгаПром','6306006006','E009','key',50);

INSERT INTO employees VALUES
 ('E001','А. Волков','CEO','ceo',NULL,'volkov@severprom.example','active'),
 ('E002','М. Соколова','CFO','finance','E001','sokolova@severprom.example','active'),
 ('E003','И. Орлов','CCO','sales','E001','orlov@severprom.example','active'),
 ('E004','П. Медведев','Production Director','production','E001','medvedev@severprom.example','active'),
 ('E005','Е. Лебедева','Logistics Lead','logistics','E001','lebedeva@severprom.example','active'),
 ('E006','Н. Козлов','Warehouse Lead','warehouse','E005','kozlov@severprom.example','active'),
 ('E007','С. Морозов','ERP PMO','pmo','E001','morozov@severprom.example','active'),
 ('E008','А. Сидоров','Sales Manager','sales','E003','sidorov@severprom.example','active'),
 ('E009','О. Кузнецова','Sales Manager','sales','E003','kuznetsova@severprom.example','active'),
 ('E010','Д. Попов','Sales Manager','sales','E003','popov@severprom.example','active'),
 ('E011','Т. Белова','Accountant','finance','E002','belova@severprom.example','active'),
 ('E012','Р. Новиков','HR Lead','hr','E001','novikov@severprom.example','active');

INSERT INTO orders VALUES
 ('SO-1001','2026-06-03','C-URAL','E008','won','CRM'),
 ('SO-1002','2026-06-05','C-SIB','E008','won','CRM'),
 ('SO-1003','2026-06-08','C-TECH','E009','won','CRM'),
 ('SO-1004','2026-06-10','C-VOLGA','E009','won','CRM'),
 ('SO-1005','2026-06-12','C-BETA','E010','won','CRM'),
 ('SO-1006','2026-06-15','C-URAL','E008','won','CRM'),
 ('SO-1007','2026-06-18','C-SIB','E008','won','CRM'),
 ('SO-1008','2026-06-20','C-ALFA','E008','lost','CRM'),
 ('SO-1009','2026-06-22','C-TECH','E009','won','CRM'),
 ('SO-1010','2026-06-25','C-BETA','E010','won','CRM');

INSERT INTO order_lines VALUES
 ('SO-1001','ASM-100',20,8200000),
 ('SO-1002','ASM-100',15,6100000),
 ('SO-1003','ASM-200',8,5400000),
 ('SO-1004','ASM-100',12,4800000),
 ('SO-1005','ASM-100',10,3900000),
 ('SO-1006','ASM-200',6,5100000),
 ('SO-1007','ASM-100',7,2800000),
 ('SO-1008','ASM-100',25,9000000),
 ('SO-1009','ASM-100',5,2100000),
 ('SO-1010','ASM-200',4,2100000);

INSERT INTO inventory_balances VALUES
 ('2026-06-30','WH-MAIN','K12',420,380),
 ('2026-06-30','WH-LINE','K12',0,0),
 ('2026-06-30','WH-MAIN','ASM-100',40,40),
 ('2026-06-30','WH-MAIN','ASM-200',12,12);

INSERT INTO payments VALUES
 ('PAY-501','2026-06-05','V-NORD',4200000,'К-12 партия PO-760','SUP-NORD-2024','E005'),
 ('PAY-502','2026-06-12','V-ALLY',950000,'Консультационные услуги акт АС-17','CONS-2026-14','E002'),
 ('PAY-503','2026-06-20','V-GLOB',810000,'Метизы','SUP-GLOB-2023','E005'),
 ('PAY-504','2026-06-28','V-ALLY',900000,'Сопровождение внедрения акт АС-18','CONS-2026-14','E002'),
 ('PAY-505','2026-07-03','V-NORD',2100000,'К-12 partial PO-778','SUP-NORD-2024','E005');

COMMIT;
