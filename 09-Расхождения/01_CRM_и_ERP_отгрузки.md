---
document_id: CF-001
title: CRM vs ERP отгрузки
department: pmo
owner: А. Волков
created: 2026-07-06
valid_until: 2026-08-06
version: 1
classification: internal
confidence: medium
source_system: Manual
---

# Conflict · CRM vs ERP отгрузки

## Источник A · CRM / коммерция
В оперативной сводке и устных статусах коммерции: «закрыто / отгружено порядка **120** учётных позиций» за июнь.
В `продажи_заказы.csv` сумма qty по won-линиям ASM: **87** (без lost SO-1008).

## Источник B · ERP `05-ERP_и_склад/transactions/продажи_заказы.csv`
Сумма `qty_shipped`: **83** (частичные отгрузки C-VOLGA, C-SIB).
В отдельном KPI-файле производства фигурирует оценка отгрузки **90** шт. готовых узлов.

## Вопрос агенту
Какой источник использовать для отчёта директору? Что запросить у коммерции, склада и ERP?
