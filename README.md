## Репозиторий с примерами начальных решений SQL

### CFT
***
>   В рамках подключения к системе MDM новой системы-источника, была реализована процедура обработки файла со списком кросс-ссылок клиентов для обеспечения онлайн-взаимодействия системы МДМ с новой системой.

**control** - файл для управления загрузкой данных из файла во временную таблицу

**mdm_cft.sh** - bash-скрипт для управления установкой

**mdm_cft_drop_tbl.sh** - bash-скрипт для удаления временной таблицы и таблицы с логами

**MAIN** - основной SQL-скрипт

**TEMP_TABLE**, **LOG_TABLE** - создание временной таблицы и таблицы с логами

**DROP_TEMP_TABLE**, **DROP_LOG_TABLE** - удаление временной таблицы и таблицы с логами



### Audit
***
>   В рамках выполнения задачи по аудиту экспорта/импорта/печати информации о клиентах банка было реализовано начальное решение, подразумевающее заполнение таблицы всеми апплетами, имеющимися на указанных в ТЗ экранах.

 **Main** - директория с SQL файлами и bash-скриптом для управления установкой.

  **Back** - директория с SQL файлами и bash-скриптом для управления откатом изменений.




### Mortgage
***
> В рамках разработки новой функиональности, реализовано начальное решение, предполагающее добавление сотрудникам прав на доступ к новым экранам

**ADD_EMPLOYEES** - основной SQL-скрипт

